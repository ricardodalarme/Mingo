import 'package:authentication_service/authentication_service.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

class AuthenticationRepository({required final AuthenticationService _authenticationService}) {
  final Logger _logger = Logger('AuthRepository');
  bool get isAuthenticated => _authenticationService.isAuthenticated;

  UserSession get userSession => _authenticationService.userSession;
  Stream<bool> get isAuthenticatedStream => _authenticationService.authStateChanges;

  String? getAccessToken() => _authenticationService.currentSession?.accessToken;

  /// The access token, renewed first when it is about to expire.
  Future<String?> getFreshAccessToken() => _authenticationService.getFreshAccessToken();

  /// Renews the session; false when there is none or it cannot be renewed.
  Future<bool> refreshSession() => _authenticationService.refreshSession();

  /// The auth provider that created the session, or null when it cannot be read.
  String? get loginProvider => _authenticationService.loginProvider;

  /// The signed-in user's id, which is also the profile id.
  String? get currentUserId => _authenticationService.currentSession?.user.id;

  Future<void> logInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _authenticationService.signInWithEmailAndPassword(email: email, password: password);
    } on AuthenticationException catch (exception, stackTrace) {
      _logger.error('Failed to sign in', error: exception, stackTrace: stackTrace);
      throw _toLocalizedException(exception);
    }
  }

  Future<void> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _authenticationService.signUpWithEmailAndPassword(email: email, password: password);
    } on AuthenticationException catch (exception) {
      throw _toLocalizedException(exception);
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      await _authenticationService.signInWithGoogle();
    } on AuthenticationException catch (exception) {
      throw _toLocalizedException(exception);
    }
  }

  Future<void> logInWithApple() async {
    try {
      await _authenticationService.signInWithApple();
    } on AuthenticationException catch (exception) {
      throw _toLocalizedException(exception);
    }
  }

  Future<void> logOut() async {
    await _authenticationService.signOut();
  }

  LocalizedException _toLocalizedException(AuthenticationException exception) {
    const codes = {
      'invalid-email-password': 'invalid_credentials',
      'user-already-exists': 'user_already_exists',
      'unverified-user': 'email_not_confirmed',
      'password-too-short': 'weak_password',
      'password-in-hibp-database': 'weak_password',
      'signup-disabled': 'signup_disabled',
      'disabled-user': 'user_banned',
      'invalid-refresh-token': 'session_not_found',
      'invalid-request': 'validation_failed',
      'locale-not-allowed': 'validation_failed',
      'provider_not_configured': 'provider_disabled',
      'network_error': 'NETWORK',
    };

    return LocalizedException(l10nKey: codes[exception.code] ?? 'other');
  }
}
