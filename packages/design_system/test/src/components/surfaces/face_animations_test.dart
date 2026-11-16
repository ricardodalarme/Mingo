import 'dart:convert';
import 'dart:io';

import 'package:design_system/design_system.dart';
import 'package:design_system/src/components/surfaces/face_animations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _DiskBundle() extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    final file = File(key.replaceFirst('packages/design_system/', ''));
    final bytes = Uint8List.fromList(file.readAsBytesSync());

    return ByteData.sublistView(bytes);
  }
}

class _BrokenBundle() extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) => Future.error(Exception('missing $key'));
}

void main() {
  setUp(FaceAnimations.reset);

  group('animation files', () {
    const frames = {FaceClip.enter: 36, FaceClip.idle: 150, FaceClip.pop: 24};

    for (final kind in FaceKind.values) {
      for (final clip in FaceClip.values) {
        test('${kind.name} ${clip.name} is a 32 point Lottie with the baked ink', () {
          final text = File('assets/faces/${kind.name}_${clip.fileSuffix}.json').readAsStringSync();
          final json = jsonDecode(text) as Map<String, dynamic>;

          expect(text, contains('[0.17,0.13,0.15,1]'));
          expect(json['op'], frames[clip]);
          expect(json['w'], 32);
        });
      }
    }
  });

  test('asset keys point into the design system package', () {
    expect(
      FaceAnimations.assetKeyFor(FaceKind.tense, FaceClip.enter),
      'packages/design_system/assets/faces/tense_in.json',
    );
  });

  test('preload keeps every face and clip in memory', () async {
    await FaceAnimations.preload(bundle: _DiskBundle());

    for (final kind in FaceKind.values) {
      for (final clip in FaceClip.values) {
        expect(FaceAnimations.compositionFor(kind, clip), isNotNull, reason: '$kind $clip');
      }
    }
  });

  test('preload does not throw when files cannot be loaded', () async {
    await FaceAnimations.preload(bundle: _BrokenBundle());

    expect(FaceAnimations.compositionFor(FaceKind.good, FaceClip.idle), isNull);
  });
}
