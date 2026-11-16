import 'dart:convert';

/// Reads a `jsonb` value, which the server may send as JSON text or already decoded.
Object? decodeJsonb(Object? value) {
  if (value is! String) return value;

  try {
    return jsonDecode(value);
  } on FormatException {
    return value;
  }
}

/// Writes a `jsonb` value as JSON text.
String encodeJsonb(Object? value) => jsonEncode(value);
