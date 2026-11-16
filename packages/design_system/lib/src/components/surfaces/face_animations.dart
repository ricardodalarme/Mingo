import 'package:design_system/src/components/surfaces/base_face.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

/// The three animations every face has.
enum FaceClip() {
  enter,
  idle,
  pop,
}

extension FaceClipFile on FaceClip {
  /// Suffix of the asset file name.
  String get fileSuffix => switch (this) {
    .enter => 'in',
    .idle => 'idle',
    .pop => 'pop',
  };
}

/// The face animation files, parsed once and kept in memory.
abstract final class FaceAnimations() {
  static const String _assetPrefix = 'packages/design_system/assets/faces';

  static final Map<String, LottieComposition> _compositions = {};
  static bool _hasLoggedFailure = false;

  /// Asset key of the animation file for [kind] and [clip].
  static String assetKeyFor(FaceKind kind, FaceClip clip) =>
      '$_assetPrefix/${kind.name}_${clip.fileSuffix}.json';

  /// Loads and parses every animation file; a file that fails is skipped and its face stays static.
  static Future<void> preload({AssetBundle? bundle}) async {
    final source = bundle ?? rootBundle;
    await Future.wait([
      for (final kind in FaceKind.values)
        for (final clip in FaceClip.values) _load(source, kind, clip),
    ]);
  }

  /// The parsed animation for [kind] and [clip], or `null` when it is not loaded.
  static LottieComposition? compositionFor(FaceKind kind, FaceClip clip) =>
      _compositions[assetKeyFor(kind, clip)];

  /// Prints the first failure to render an animation.
  static void reportFailure(Object error) {
    if (_hasLoggedFailure) return;
    _hasLoggedFailure = true;
    debugPrint('BaseFace animation unavailable, showing the static face: $error');
  }

  /// Registers [composition] for [kind] and [clip].
  @visibleForTesting
  static void register(FaceKind kind, FaceClip clip, LottieComposition composition) {
    _compositions[assetKeyFor(kind, clip)] = composition;
  }

  /// Forgets every loaded animation and failure.
  @visibleForTesting
  static void reset() {
    _compositions.clear();
    _hasLoggedFailure = false;
  }

  static Future<void> _load(AssetBundle bundle, FaceKind kind, FaceClip clip) async {
    final key = assetKeyFor(kind, clip);
    try {
      final data = await bundle.load(key);
      _compositions[key] = await LottieComposition.fromByteData(data);
    } on Object catch (error) {
      reportFailure('$key: $error');
    }
  }
}
