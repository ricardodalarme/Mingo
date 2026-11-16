import 'package:design_system/design_system.dart';
import 'package:design_system/src/components/surfaces/face_motion_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a selected face idles', () {
    expect(resolveFaceMotion(motion: null, selected: true, size: FaceSize.medium), FaceMotion.idle);
  });

  test('a selected showcase face idles instead of entering', () {
    expect(
      resolveFaceMotion(motion: null, selected: true, size: FaceSize.showcase),
      FaceMotion.idle,
    );
  });

  test('a showcase face enters', () {
    expect(
      resolveFaceMotion(motion: null, selected: false, size: FaceSize.showcase),
      FaceMotion.enter,
    );
  });

  test('every other face stays still', () {
    for (final size in FaceSize.values.where((size) => size != FaceSize.showcase)) {
      expect(
        resolveFaceMotion(motion: null, selected: false, size: size),
        FaceMotion.still,
        reason: size.name,
      );
    }
  });

  test('an explicit motion wins over the automatic choice', () {
    expect(
      resolveFaceMotion(motion: FaceMotion.still, selected: true, size: FaceSize.showcase),
      FaceMotion.still,
    );
    expect(
      resolveFaceMotion(motion: FaceMotion.enter, selected: false, size: FaceSize.small),
      FaceMotion.enter,
    );
  });
}
