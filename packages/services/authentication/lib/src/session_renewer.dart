import 'dart:async';

import 'package:authentication_service/src/jwt.dart';
import 'package:logger/logger.dart';
import 'package:nhost_auth_dart/nhost_auth_dart.dart';
import 'package:nhost_sdk/nhost_sdk.dart' show ApiException, unauthorizedStatus;

/// How far ahead of its expiry the access token is renewed. It must outlast the slowest request,
/// which is a mutation with a 30 second limit.
const Duration _renewalMargin = Duration(seconds: 60);

/// Whether the server refused the refresh token, as opposed to not being reachable.
///
/// It refuses a token it does not know (401) or cannot read (400); asking again cannot change
/// either answer.
bool _isRefusal(Object error) =>
    error is ApiException && (error.statusCode == unauthorizedStatus || error.statusCode == 400);

/// Renews the session through the Nhost client, one renewal at a time.
///
/// The server revokes a refresh token when it is used, so a renewal is never started when another
/// one is running or has just made the failing token stale. A failure that is not a refusal keeps
/// the session and pauses renewing, longer after a 429, so a server that is down or rate limiting
/// is not asked again with every request.
class SessionRenewer({
  required final NhostAuthClient _auth,
  required final Future<void> Function() _onRenewed,
  required final Future<void> Function() _onRefused,
  final Duration cooldown = const Duration(seconds: 10),
}) {
  static final Logger _logger = Logger('SessionRenewer');
  static const int _tooManyRequests = 429;

  Future<bool>? _running;
  DateTime? _pausedUntil;
  Timer? _timer;

  /// The access token the session holds now.
  String? get current => _auth.accessToken;

  /// Whether there is no access token, or it is about to expire.
  bool get isExpiring {
    final token = current;

    return token == null || expiresWithin(token, _renewalMargin);
  }

  /// Renews the session; false when it could not be renewed.
  ///
  /// With [rejected], the token a request was just refused with: a different token already held
  /// means someone else renewed first, and nothing is sent.
  Future<bool> renew({String? rejected}) {
    final held = current;
    if (rejected != null && held != null && held != rejected) return Future.syncValue(true);

    return _running ??= _renew().whenComplete(() => _running = null);
  }

  /// Renews once the token is about to expire.
  void schedule() {
    _timer?.cancel();
    final token = current;
    final expiresAt = token == null ? null : jwtExpiry(token);
    if (expiresAt == null) return;

    final wait = expiresAt.subtract(_renewalMargin).difference(DateTime.now());
    _timer = Timer(wait.isNegative ? Duration.zero : wait, () => unawaited(renew()));
  }

  void cancel() => _timer?.cancel();

  Future<bool> _renew() async {
    final refreshToken = _auth.userSession.session?.refreshToken;
    if (refreshToken == null) return false;
    final pausedUntil = _pausedUntil;
    if (pausedUntil != null && DateTime.now().isBefore(pausedUntil)) return false;

    try {
      await _auth.signInWithRefreshToken(refreshToken);
      _pausedUntil = null;
      await _onRenewed();

      return true;
    } on Object catch (error) {
      if (_isRefusal(error)) {
        // Another session may have started while this one was waiting; it is not this one's to end.
        final now = _auth.userSession.session?.refreshToken;
        if (now == null || now == refreshToken) await _onRefused();
      } else {
        final pause = error is ApiException && error.statusCode == _tooManyRequests
            ? cooldown * 6
            : cooldown;
        _pausedUntil = DateTime.now().add(pause);
        _logger.warning(
          'The session could not be renewed (${error is ApiException ? error.statusCode : error.runtimeType}), trying again in ${pause.inSeconds}s',
        );
      }

      return false;
    }
  }
}
