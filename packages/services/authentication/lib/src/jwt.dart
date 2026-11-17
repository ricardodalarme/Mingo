import 'dart:convert';

/// When the JWT [token] stops working, from its `exp` claim; null when it has none.
DateTime? jwtExpiry(String token) {
  final parts = token.split('.');
  if (parts.length != 3) return null;
  try {
    final claims = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    final exp = claims is Map ? claims['exp'] : null;

    return exp is num ? DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000, isUtc: true) : null;
  } on FormatException {
    return null;
  }
}

/// Whether the JWT [token] stops working within [margin] from now.
bool expiresWithin(String token, Duration margin) {
  final expiry = jwtExpiry(token);

  return expiry != null && !DateTime.now().isBefore(expiry.subtract(margin));
}
