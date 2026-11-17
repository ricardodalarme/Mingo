import 'dart:convert';

import 'package:authentication_service/src/jwt.dart';
import 'package:flutter_test/flutter_test.dart';

String _jwt(Object claims) {
  String part(Object value) => base64Url.encode(utf8.encode(jsonEncode(value))).replaceAll('=', '');

  return '${part({'alg': 'none'})}.${part(claims)}.';
}

void main() {
  group('jwtExpiry', () {
    test('reads the exp claim', () {
      expect(jwtExpiry(_jwt({'exp': 4102444800})), DateTime.utc(2100));
    });

    test('is null without an exp claim', () {
      expect(jwtExpiry(_jwt({'sub': 'user-1'})), isNull);
    });

    test('is null when exp is not a number', () {
      expect(jwtExpiry(_jwt({'exp': 'soon'})), isNull);
    });

    test('is null for a token that is not a JWT', () {
      expect(jwtExpiry('abc'), isNull);
      expect(jwtExpiry('a.!!!.c'), isNull);
    });
  });

  group('expiresWithin', () {
    String expiringIn(Duration time) =>
        _jwt({'exp': DateTime.now().add(time).millisecondsSinceEpoch ~/ 1000});

    test('is true inside the margin', () {
      expect(
        expiresWithin(expiringIn(const Duration(seconds: 30)), const Duration(minutes: 1)),
        isTrue,
      );
    });

    test('is true once expired', () {
      expect(expiresWithin(expiringIn(const Duration(hours: -1)), Duration.zero), isTrue);
    });

    test('is false with time to spare', () {
      expect(
        expiresWithin(expiringIn(const Duration(minutes: 10)), const Duration(minutes: 1)),
        isFalse,
      );
    });

    test('is false for a token with no expiry', () {
      expect(expiresWithin(_jwt({'sub': 'user-1'}), const Duration(minutes: 1)), isFalse);
    });
  });
}
