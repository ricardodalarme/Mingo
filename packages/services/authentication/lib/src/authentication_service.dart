import 'dart:async';
import 'dart:convert';

import 'package:authentication_service/src/current_user.dart';
import 'package:authentication_service/src/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:secure_storage_service/secure_storage_service.dart';

/// A signed-in person and the tokens that prove it.
class const AuthSession({
  required final String accessToken,
  required final String refreshToken,
  required final DateTime expiresAt,
  required final AuthUser user,
}) {
  factory fromJson(Map<String, Object?> json) => AuthSession(
    accessToken: json['accessToken']! as String,
    refreshToken: json['refreshToken']! as String,
    expiresAt: DateTime.parse(json['expiresAt']! as String),
    user: AuthUser.fromJson(json['user']! as Map<String, Object?>),
  );

  bool get isExpired => DateTime.now().isAfter(expiresAt.subtract(const Duration(seconds: 30)));

  Map<String, Object?> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresAt': expiresAt.toIso8601String(),
    'user': user.toJson(),
  };
}

class const AuthUser({
  required final String id,
  required final String email,
  required final String displayName,
}) {
  factory fromJson(Map<String, Object?> json) => AuthUser(
    id: json['id']! as String,
    email: (json['email'] as String?) ?? '',
    displayName: (json['displayName'] as String?) ?? '',
  );

  Map<String, Object?> toJson() => {'id': id, 'email': email, 'displayName': displayName};
}

/// Talks to the Nhost Auth API and keeps the session in secure storage.
class AuthenticationService({
  final http.Client? httpClient,
  final SecureStorageService? secureStorage,
}) {
  static const _sessionKey = 'auth.session';

  late final http.Client _http = httpClient ?? http.Client();
  late final SecureStorageService _storage = secureStorage ?? SecureStorageService();
  final StreamController<bool> _authChanges = StreamController<bool>.broadcast();

  AuthSession? _session;
  String _baseUrl = '';

  AuthSession? get currentSession => _session;

  CurrentUser? get currentUser {
    final user = _session?.user;
    if (user == null) return null;

    return CurrentUser(email: user.email, firstName: user.displayName, lastName: '');
  }

  String? get loginProvider {
    if (_session == null) return null;

    return 'email';
  }

  bool get isAuthenticated => _session != null;

  Stream<bool> get authStateChanges => _authChanges.stream;

  Future<void> initialize({required String url}) async {
    if (url.isEmpty) throw AuthenticationException(code: 'invalid_configuration');
    _baseUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;

    final stored = await _storage.read(key: _sessionKey);
    if (stored == null) return;
    try {
      _session = AuthSession.fromJson(jsonDecode(stored) as Map<String, Object?>);
      _authChanges.add(isAuthenticated);
    } on FormatException {
      await _storage.delete(key: _sessionKey);
    }
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    await _persist(await _post('/signin/email-password', {'email': email, 'password': password}));
  }

  Future<void> signUpWithEmailAndPassword({required String email, required String password}) async {
    await _persist(
      await _post('/signup/email-password', {
        'email': email,
        'password': password,
        'options': {'redirectTo': 'mingo://auth'},
      }),
    );
  }

  Future<void> resetPasswordForEmail({required String email}) async {
    await _send('/user/password/reset', {
      'email': email,
      'options': {'redirectTo': 'mingo://auth'},
    });
  }

  Future<void> signInWithGoogle() =>
      Future.error(AuthenticationException(code: 'provider_not_configured'));

  Future<void> signInWithApple() =>
      Future.error(AuthenticationException(code: 'provider_not_configured'));

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final session = _session;
    if (session == null) throw AuthenticationException(code: 'session_not_found');

    await signInWithEmailAndPassword(email: session.user.email, password: currentPassword);
    await _send('/user/password', {'newPassword': newPassword}, token: _session!.accessToken);
    await _clear();
  }

  Future<String?> getFreshAccessToken() async {
    final session = _session;
    if (session == null) return null;
    if (!session.isExpired) return session.accessToken;
    if (!await refreshSession()) return session.accessToken;

    return _session?.accessToken;
  }

  Future<bool> refreshSession() async {
    final session = _session;
    if (session == null) return false;

    try {
      final body = await _request('POST', '/token', {'refreshToken': session.refreshToken});
      await _persist(_sessionFrom(body, fallback: session.user));
      return true;
    } on AuthenticationException {
      await _clear();
      return false;
    }
  }

  Future<void> signOut() async {
    final session = _session;
    try {
      if (session != null) {
        await _request('POST', '/signout', {
          'refreshToken': session.refreshToken,
        }, token: session.accessToken);
      }
    } on AuthenticationException {
      // The session is cleared even when the server cannot be told.
    } finally {
      await _clear();
    }
  }

  Future<AuthSession> _post(String path, Map<String, Object?> body) async {
    final payload = await _request('POST', path, body);
    final session = payload['session'];
    if (session is! Map<String, Object?>) throw AuthenticationException(code: 'invalid_response');

    return _sessionFrom(session);
  }

  Future<void> _send(String path, Map<String, Object?> body, {String? token}) =>
      _request('POST', path, body, token: token);

  Future<Map<String, Object?>> _request(
    String method,
    String path,
    Map<String, Object?> body, {
    String? token,
  }) async {
    final headers = {'content-type': 'application/json'};
    if (token != null) headers['authorization'] = 'Bearer $token';

    late http.Response response;
    try {
      response = await _http.post(
        Uri.parse('$_baseUrl$path'),
        headers: headers,
        body: jsonEncode(body),
      );
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(AuthenticationException(code: 'network_error'), stackTrace);
    }

    final decoded = response.body.isEmpty
        ? <String, Object?>{}
        : jsonDecode(response.body) as Map<String, Object?>;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AuthenticationException(code: (decoded['error'] as String?) ?? 'auth_error');
    }

    return decoded;
  }

  AuthSession _sessionFrom(Map<String, Object?> json, {AuthUser? fallback}) {
    final user = json['user'] as Map<String, Object?>? ?? const {};
    final expiresIn = (json['accessTokenExpiresIn'] as num?)?.toInt() ?? 900;

    return AuthSession(
      accessToken: json['accessToken']! as String,
      refreshToken: json['refreshToken']! as String,
      expiresAt: DateTime.now().add(Duration(seconds: expiresIn)),
      user: (user['id'] as String?) == null
          ? (fallback ?? const AuthUser(id: '', email: '', displayName: ''))
          : AuthUser(
              id: user['id']! as String,
              email: (user['email'] as String?) ?? '',
              displayName: (user['displayName'] as String?) ?? '',
            ),
    );
  }

  Future<void> _persist(AuthSession session) async {
    _session = session;
    await _storage.write(key: _sessionKey, value: jsonEncode(session.toJson()));
    _authChanges.add(isAuthenticated);
  }

  Future<void> _clear() async {
    _session = null;
    await _storage.delete(key: _sessionKey);
    _authChanges.add(false);
  }
}
