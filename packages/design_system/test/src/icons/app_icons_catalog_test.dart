import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the generated icon class has one constant per catalog SVG', () {
    final svgs = Directory('icons')
        .listSync()
        .whereType<File>()
        .map((file) => file.uri.pathSegments.last.replaceAll('.svg', '').replaceAll('-', '_'))
        .toSet();
    final source = File('lib/src/icons/app_icons.dart').readAsStringSync();
    final constants = RegExp(r'static const IconData (\w+) =')
        .allMatches(source)
        .map((m) => m[1]!)
        .toSet();

    expect(svgs, hasLength(83));
    expect(constants, svgs);
  });

  test('the new catalog icons are present', () {
    final source = File('lib/src/icons/app_icons.dart').readAsStringSync();
    for (final name in [
      'message',
      'flame',
      'history',
      'gamepad',
      'sliders_vertical',
      'jar',
      'notebook',
      'trending_up',
      'prohibit',
      'square_minus',
      'initial',
    ]) {
      expect(source, contains('static const IconData $name ='), reason: name);
    }
  });
}
