import 'dart:io';
import 'dart:typed_data';

import 'package:design_system/design_system.dart';
import 'package:design_system/src/components/surfaces/face_animations.dart';
import 'package:design_system/src/components/surfaces/face_lottie_player.dart';
import 'package:design_system/src/components/surfaces/face_svg.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

const double _side = 128;
const Color _ink = Color(0xFF2B2126);

Future<LottieComposition> _load(FaceKind kind, FaceClip clip) {
  final bytes = File('assets/faces/${kind.name}_${clip.fileSuffix}.json').readAsBytesSync();
  return LottieComposition.fromBytes(bytes);
}

Future<Uint8List> _pixels(WidgetTester tester, Widget child) async {
  final key = GlobalKey();
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RepaintBoundary(
          key: key,
          child: ColoredBox(
            color: const Color(0xFFFFFFFF),
            child: SizedBox(width: _side, height: _side, child: child),
          ),
        ),
      ),
    ),
  );
  late Uint8List bytes;
  await tester.runAsync(() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    await tester.pump();
    final boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final data = await image.toByteData();
    bytes = data!.buffer.asUint8List();
  });

  return bytes;
}

int _inkPixels(Uint8List pixels) {
  var count = 0;
  for (var i = 0; i < pixels.length; i += 4) {
    if (pixels[i] < 200) count++;
  }

  return count;
}

double _meanDifference(Uint8List a, Uint8List b) {
  var total = 0;
  for (var i = 0; i < a.length; i++) {
    total += (a[i] - b[i]).abs();
  }

  return total / a.length;
}

Widget _lottie(LottieComposition composition, double offset) => FaceLottiePlayer(
  composition: composition,
  tint: _ink,
  isLooping: false,
  startOffset: offset,
  isPaused: true,
  onCompleted: () {},
);

void main() {
  for (final kind in FaceKind.values) {
    testWidgets('${kind.name} animation frames match the static drawing', (tester) async {
      final reference = await _pixels(
        tester,
        SvgPicture.string(faceSvgFor(kind, _ink), width: _side, height: _side),
      );
      expect(_inkPixels(reference), greaterThan(100), reason: 'reference is drawn');
      final idle = await _load(kind, FaceClip.idle);
      final pop = await _load(kind, FaceClip.pop);
      final enter = await _load(kind, FaceClip.enter);

      final frames = {
        'idle first': _lottie(idle, 0),
        'pop first': _lottie(pop, 0),
        'pop last': _lottie(pop, 1),
        'enter last': _lottie(enter, 1),
      };
      for (final entry in frames.entries) {
        final pixels = await _pixels(tester, entry.value);
        expect(_inkPixels(pixels), greaterThan(100), reason: '${entry.key} is drawn');
        expect(_meanDifference(reference, pixels), lessThan(1), reason: entry.key);
      }

      final midIdle = await _pixels(tester, _lottie(idle, 0.5));
      expect(_meanDifference(reference, midIdle), greaterThan(0.01), reason: 'idle moves');
    });
  }

  for (final kind in FaceKind.values) {
    testWidgets('${kind.name} tint reaches every layer', (tester) async {
      const tint = Color(0xFFE00000);
      for (final clip in FaceClip.values) {
        final composition = await _load(kind, clip);
        final pixels = await _pixels(
          tester,
          FaceLottiePlayer(
            composition: composition,
            tint: tint,
            isLooping: false,
            startOffset: 0.5,
            isPaused: true,
            onCompleted: () {},
          ),
        );
        var tinted = 0;
        var dark = 0;
        for (var i = 0; i < pixels.length; i += 4) {
          final isOpaque = pixels[i + 3] == 255;
          if (isOpaque && pixels[i] > 200 && pixels[i + 1] < 60) tinted++;
          if (isOpaque && pixels[i] < 120 && pixels[i + 1] < 120) dark++;
        }
        expect(tinted, greaterThan(100), reason: '${kind.name} ${clip.name}');
        expect(dark, 0, reason: '${kind.name} ${clip.name} keeps its baked color');
      }
    });
  }
}
