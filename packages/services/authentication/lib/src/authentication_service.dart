import 'dart:async';
import 'dart:convert';

import 'package:authentication_service/src/current_user.dart';
import 'package:authentication_service/src/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:nhost_auth_dart/nhost_auth_dart.dart';
import 'package:nhost_sdk/nhost_sdk.dart'
    show ApiException, AuthenticationState, NhostException, Session, UserSession;
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

/// Talks to Nhost Auth and keeps the session in secure storage.
class AuthenticationService({
  final NhostAuthClient? authClient,
  final SecureStorageService? secureStorage,
  final http.Client? httpClient,
}) {
  static const _sessionKey = 'auth.session';

  late final SecureStorageService _storage = secureStorage ?? SecureStorageService();
  final StreamController<bool> _authChanges = StreamController<bool>.broadcast();

  NhostAuthClient? _client;

  NhostAuthClient get _auth => _client!;

  UserSession get userSession => _auth.userSession;

  AuthSession? get currentSession {
    final session = _auth.userSession.session;
    if (session == null) return null;

    return _map(session);
  }

  CurrentUser? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;

    return CurrentUser(email: user.email ?? '', firstName: user.displayName, lastName: '');
  }

  String? get loginProvider => currentSession == null ? null : 'email';

  bool get isAuthenticated => _auth.authenticationState == AuthenticationState.signedIn;

  Stream<bool> get authStateChanges => _authChanges.stream;

  Future<void> initialize({required String url}) async {
    if (url.isEmpty) throw AuthenticationException(code: 'invalid_configuration');
    _client = authClient ?? NhostAuthClient(url: url, httpClient: httpClient);
    _auth.addAuthStateChangedCallback((state) {
      _authChanges.add(state == AuthenticationState.signedIn);
    });
    _auth.addTokenChangedCallback(() => unawaited(_persist()));

    final stored = await _storage.read(key: _sessionKey);
    if (stored == null) return;
    try {
      final session = Session.fromJson(jsonDecode(stored));
      final refreshToken = session.refreshToken;
      if (session.accessToken == null || refreshToken == null) {
        throw const FormatException();
      }
      final expiry = _expiry(session.accessToken);
      if (expiry == null || DateTime.now().isAfter(expiry.subtract(const Duration(seconds: 30)))) {
        await _auth.signInWithRefreshToken(refreshToken);
        await _persist();
        return;
      }
      // Restoring the stored session is the documented use of this setter; the annotation is about tests.
      // ignore: invalid_use_of_visible_for_testing_member
      await _auth.setSession(
        session.copyWith(accessTokenExpiresIn: expiry.difference(DateTime.now())),
      );
    } on Object {
      await _clear();
    }
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) =>
      _guard(() async {
        final response = await _auth.signInEmailPassword(email: email, password: password);
        if (response.mfa != null) throw AuthenticationException(code: 'mfa_required');
        await _persist();
      });

  Future<void> signUpWithEmailAndPassword({required String email, required String password}) =>
      _guard(() async {
        await _auth.signUp(email: email, password: password, redirectTo: 'mingo://auth');
        await _persist();
      });

  Future<void> resetPasswordForEmail({required String email}) =>
      _guard(() => _auth.resetPassword(email: email, redirectTo: 'mingo://auth'));

  Future<void> signInWithGoogle() =>
      Future.error(AuthenticationException(code: 'provider_not_configured'));

  Future<void> signInWithApple() =>
      Future.error(AuthenticationException(code: 'provider_not_configured'));

  Future<void> changePassword({required String currentPassword, required String newPassword}) =>
      _guard(() async {
        final email = _auth.currentUser?.email;
        if (email == null || email.isEmpty) {
          throw AuthenticationException(code: 'session_not_found');
        }

        await _auth.signInEmailPassword(email: email, password: currentPassword);
        await _auth.changePassword(newPassword: newPassword);
        await _clear();
      });

  Future<String?> getFreshAccessToken() async {
    final token = _auth.accessToken;
    if (token == null) return null;
    final expiry = _expiry(token);
    if (expiry != null && DateTime.now().isAfter(expiry.subtract(const Duration(seconds: 60)))) {
      if (await refreshSession()) return _auth.accessToken;
    }

    return token;
  }

  DateTime? _expiry(String? token) {
    if (token == null) return null;
    final parts = token.split('.');
    if (parts.length != 3) return null;
    try {
      final payload =
          jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1])))) as Map;
      final exp = payload['exp'];
      if (exp is! num) return null;

      return DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000, isUtc: true);
    } on Object {
      return null;
    }
  }

  Future<bool> refreshSession() async {
    final refreshToken = _auth.userSession.session?.refreshToken;
    if (refreshToken == null) return false;

    try {
      await _auth.signInWithRefreshToken(refreshToken);
      await _persist();
      return true;
    } on Object {
      await _clear();
      return false;
    }
  }

  void dispose() {
    _auth.close();
    unawaited(_authChanges.close());
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on Object {
      // The local session is cleared even when the server cannot be told.
    } finally {
      await _clear();
    }
  }

  AuthSession _map(Session session) => AuthSession(
    accessToken: session.accessToken ?? '',
    refreshToken: session.refreshToken ?? '',
    expiresAt: DateTime.now().add(session.accessTokenExpiresIn ?? const Duration(minutes: 15)),
    user: AuthUser(
      id: session.user?.id ?? '',
      email: session.user?.email ?? '',
      displayName: session.user?.displayName ?? '',
    ),
  );

  Future<void> _persist() async {
    final session = _auth.userSession.session;
    if (session == null) return;
    await _storage.write(key: _sessionKey, value: jsonEncode(session.toJson()));
  }

  Future<void> _clear() async {
    await _storage.delete(key: _sessionKey);
    // Clearing locally is the documented way to end an unusable refresh token without a network call.
    // ignore: invalid_use_of_visible_for_testing_member
    await _auth.clearSession();
    _authChanges.add(false);
  }

  Future<void> _guard(Future<void> Function() action) async {
    try {
      await action();
    } on AuthenticationException {
      rethrow;
    } on ApiException catch (error, stackTrace) {
      final body = error.body;
      final code = body is Map && body['error'] is String ? body['error'] as String : 'auth_error';
      Error.throwWithStackTrace(AuthenticationException(code: code), stackTrace);
    } on NhostException catch (error, stackTrace) {
      Error.throwWithStackTrace(AuthenticationException(code: 'auth_error'), stackTrace);
    }
  }
}
