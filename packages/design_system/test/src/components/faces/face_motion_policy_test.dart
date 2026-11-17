import 'package:design_system/design_system.dart';
import 'package:design_system/src/components/faces/face_motion_policy.dart';
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

  group('budget', () {
    setUp(FaceMotionBudget.reset);
    tearDown(FaceMotionBudget.reset);

    test('allows four animated faces and refuses the fifth', () {
      for (var i = 0; i < FaceMotionBudget.limit; i++) {
        expect(FaceMotionBudget.tryAcquire(), isTrue);
      }

      expect(FaceMotionBudget.tryAcquire(), isFalse);

      FaceMotionBudget.release();

      expect(FaceMotionBudget.tryAcquire(), isTrue);
    });
  });

  testWidgets('a face inside a lazy list item is detected', (tester) async {
    late bool inList;
    late bool onPage;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            Builder(
              builder: (context) {
                onPage = isInListItem(context);

                return const SizedBox.shrink();
              },
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => Builder(
                  builder: (context) {
                    inList = isInListItem(context);

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

    expect(inList, isTrue);
    expect(onPage, isFalse);
  });
}
