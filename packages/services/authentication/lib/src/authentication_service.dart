import 'dart:async';

import 'package:authentication_service/src/exceptions.dart';
import 'package:authentication_service/src/session_renewer.dart';
import 'package:authentication_service/src/session_store.dart';
import 'package:http/http.dart' as http;
import 'package:nhost_auth_dart/nhost_auth_dart.dart';
import 'package:nhost_sdk/nhost_sdk.dart'
    show ApiException, AuthenticationState, NhostException, UserSession;
import 'package:secure_storage_service/secure_storage_service.dart';

/// Talks to Nhost Auth, keeps the session in secure storage and renews it.
class AuthenticationService({
  final NhostAuthClient? authClient,
  final SecureStorageService? secureStorage,
  final http.Client? httpClient,
  final Duration refreshCooldown = const Duration(seconds: 10),
  // How long starting up waits for an expired token to be renewed; the renewal goes on after it.
  final Duration startupWait = const Duration(seconds: 3),
}) {
  // The SDK's own refresh timer throws an unhandled error when a refresh fails, so the renewer
  // schedules renewals and the SDK's timer is set too far out to ever fire.
  static const Duration _sdkRefreshInterval = Duration(days: 36500);

  final StreamController<bool> _authChanges = StreamController<bool>.broadcast();
  bool? _lastAnnounced;
  // Whether no session is meant to exist, so a renewal that finishes now is not kept.
  bool _isEnded = true;

  NhostAuthClient? _client;
  SessionStore? _store;
  SessionRenewer? _renewer;

  NhostAuthClient get _auth => _client!;
  SessionStore get _sessions => _store!;
  SessionRenewer get _renewals => _renewer!;

  /// The session the Nhost clients share; storage reads its token from it.
  UserSession get userSession => _auth.userSession;

  /// The signed-in person's id, or null when signed out.
  String? get currentUserId => _auth.currentUser?.id;

  String? get loginProvider => _auth.userSession.session == null ? null : 'email';

  bool get isAuthenticated => _auth.authenticationState == AuthenticationState.signedIn;

  Stream<bool> get authStateChanges => _authChanges.stream;

  Future<void> initialize({required String url}) async {
    if (url.isEmpty) throw AuthenticationException(code: 'invalid_configuration');
    _client =
        authClient ??
        NhostAuthClient(
          url: url,
          httpClient: httpClient,
          tokenRefreshInterval: _sdkRefreshInterval,
        );
    _store = SessionStore(secureStorage ?? SecureStorageService());
    _renewer = SessionRenewer(
      auth: _auth,
      onRenewed: _save,
      onRefused: _end,
      cooldown: refreshCooldown,
    );
    _auth.addAuthStateChangedCallback((state) => _announce(state == AuthenticationState.signedIn));
    _auth.addTokenChangedCallback(_onTokenChanged);

    final stored = await _sessions.read();
    if (stored == null) return;

    _isEnded = false;

    // Restoring the stored session is the documented use of this setter; the annotation is about tests.
    // ignore: invalid_use_of_visible_for_testing_member
    await _auth.setSession(stored);
    if (_renewals.isExpiring) {
      // Offline or the server is down: the person stays signed in with the stored session, and the
      // renewal goes on in the background.
      await _renewals.renew().timeout(startupWait, onTimeout: () => false);
    }
  }

  /// The access token, renewed first when it is about to expire; null when signed out.
  Future<String?> getFreshAccessToken() async {
    if (_renewals.current == null) return null;
    if (_renewals.isExpiring) await _renewals.renew();

    return _renewals.current;
  }

  /// Renews the session; false when it cannot be renewed.
  ///
  /// [rejected] is the token a request was just refused with: when the session already holds a
  /// different one, someone renewed first and nothing is sent.
  Future<bool> refreshSession([String? rejected]) => _renewals.renew(rejected: rejected);

  Future<void> signInWithEmailAndPassword({required String email, required String password}) =>
      _begin(() async {
        final response = await _auth.signInEmailPassword(email: email, password: password);
        if (response.mfa != null) throw AuthenticationException(code: 'mfa_required');
      });

  Future<void> signUpWithEmailAndPassword({required String email, required String password}) =>
      _begin(() async {
        await _auth.signUp(email: email, password: password, redirectTo: 'mingo://auth');
      });

  Future<void> signInWithGoogle() =>
      Future.error(AuthenticationException(code: 'provider_not_configured'));

  Future<void> signInWithApple() =>
      Future.error(AuthenticationException(code: 'provider_not_configured'));

  Future<void> signOut() async {
    _isEnded = true;
    _renewals.cancel();
    // The SDK clears the local session even when the server cannot be told.
    await _auth.signOut();
    await _end();
  }

  void dispose() {
    _renewer?.cancel();
    _client?.close();
    unawaited(_authChanges.close());
  }

  /// Runs a sign in that starts a session, so the session it makes is kept.
  Future<void> _begin(Future<void> Function() signIn) async {
    _isEnded = false;
    try {
      try {
        await signIn();
      } on Object {
        if (!isAuthenticated) _isEnded = true;
        rethrow;
      }
      await _save();
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

  /// Keeps the current session, unless the session was ended in the meantime.
  Future<void> _save() async {
    final session = _auth.userSession.session;
    if (session != null && !_isEnded) await _sessions.write(session);
  }

  void _onTokenChanged() {
    final session = _auth.userSession.session;
    if (session == null) return;
    if (_isEnded) {
      // A renewal that finished after the session ended must not bring it back.
      // ignore: invalid_use_of_visible_for_testing_member, the documented way to end a session locally
      unawaited(_auth.clearSession());
      return;
    }
    _renewals.schedule();
  }

  Future<void> _end() async {
    _isEnded = true;
    _renewals.cancel();
    await _sessions.delete();
    // Clearing locally is the documented way to end an unusable refresh token without a network call.
    // ignore: invalid_use_of_visible_for_testing_member
    await _auth.clearSession();
    _announce(false);
  }

  void _announce(bool isAuthenticated) {
    if (_lastAnnounced == isAuthenticated) return;
    _lastAnnounced = isAuthenticated;
    _authChanges.add(isAuthenticated);
  }
}
