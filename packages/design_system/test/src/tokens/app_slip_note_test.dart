import 'dart:math' as math;

import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

double _luminance(Color color) {
  double channel(double value) =>
      value <= .03928 ? value / 12.92 : math.pow((value + .055) / 1.055, 2.4).toDouble();

  return .2126 * channel(color.r) + .7152 * channel(color.g) + .0722 * channel(color.b);
}

double _contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);

  return (math.max(la, lb) + .05) / (math.min(la, lb) + .05);
}

void main() {
  group('slipNoteTilt', () {
    test('gives the same value for the same id', () {
      expect(slipNoteTilt('0b6f-slip'), slipNoteTilt('0b6f-slip'));
    });

    test('only returns the four allowed tilts', () {
      final values = {for (var i = 0; i < 200; i++) slipNoteTilt('slip-$i')};

      expect(values, {-1.6, 1.4, 1.0, -1.0});
    });

    test('is never zero and never above 1.8 degrees', () {
      for (var i = 0; i < 200; i++) {
        final tilt = slipNoteTilt('id-$i');
        expect(tilt, isNot(0));
        expect(tilt.abs(), lessThanOrEqualTo(1.8));
      }
    });

    test('covers every tilt for a set of ids', () {
      final values = {for (var i = 0; i < 40; i++) slipNoteTilt('$i')};

      expect(values.length, 4);
    });
  });

  group('AppSlipNoteColors', () {
    test('every ink reads at 4.5:1 on its background and on the note text', () {
      for (final type in SlipNoteType.values) {
        final tone = AppSlipNoteColors.standard.of(type);

        expect(_contrast(tone.ink, tone.background), greaterThanOrEqualTo(4.5), reason: type.name);
        expect(
          _contrast(AppSlipNoteColors.text, tone.background),
          greaterThanOrEqualTo(4.5),
          reason: type.name,
        );
      }
    });

    test('the day label reads at 4.5:1 on every background', () {
      for (final type in SlipNoteType.values) {
        final tone = AppSlipNoteColors.standard.of(type);

        expect(_contrast(AppSlipNoteColors.dayLabel, tone.background), greaterThanOrEqualTo(4.5));
      }
    });
  });
}
