import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:logger/logger.dart';

final class FaceAnimationsInitializer({final AssetBundle? bundle}) extends Initializer {
  static final Logger _logger = Logger('FaceAnimationsInitializer');

  @override
  FailurePolicy get failurePolicy => FailurePolicy.nonCritical;

  @override
  Future<void> initialize() {
    _logger.info('Loading face animations');

    return FaceAnimations.preload(bundle: bundle);
  }
}
