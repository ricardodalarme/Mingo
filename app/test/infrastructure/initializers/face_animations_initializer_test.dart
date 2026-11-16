import 'package:app/infrastructure/initializers/face_animations_initializer.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingBundle() extends CachingAssetBundle {
  final List<String> keys = [];

  @override
  Future<ByteData> load(String key) {
    keys.add(key);

    return Future.syncValue(ByteData.sublistView(Uint8List.fromList(const [0])));
  }
}

void main() {
  test('loads the three animations of every face', () async {
    final bundle = _RecordingBundle();

    await FaceAnimationsInitializer(bundle: bundle).initialize();

    expect(bundle.keys, hasLength(21));
    expect(
      bundle.keys,
      containsAll([
        'packages/design_system/assets/faces/good_in.json',
        'packages/design_system/assets/faces/smile_idle.json',
        'packages/design_system/assets/faces/tense_pop.json',
      ]),
    );
  });

  test('does not abort startup when it fails', () {
    expect(FaceAnimationsInitializer().failurePolicy, FailurePolicy.nonCritical);
  });
}
