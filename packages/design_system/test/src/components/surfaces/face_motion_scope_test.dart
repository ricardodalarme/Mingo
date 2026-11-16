import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('is enabled by default and found by descendants', (tester) async {
    bool? isEnabled;
    await tester.pumpWidget(
      FaceMotionScope(
        child: Builder(
          builder: (context) {
            isEnabled = FaceMotionScope.maybeOf(context)?.enabled;

            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(isEnabled, isTrue);
  });

  testWidgets('is absent when nothing provides it', (tester) async {
    FaceMotionScope? scope;
    await tester.pumpWidget(
      Builder(
        builder: (context) {
          scope = FaceMotionScope.maybeOf(context);

          return const SizedBox.shrink();
        },
      ),
    );

    expect(scope, isNull);
  });

  testWidgets('notifies dependents when it is disabled', (tester) async {
    var builds = 0;
    Widget build({required bool isEnabled}) => FaceMotionScope(
      enabled: isEnabled,
      child: Builder(
        builder: (context) {
          FaceMotionScope.maybeOf(context);
          builds++;

          return const SizedBox.shrink();
        },
      ),
    );

    await tester.pumpWidget(build(isEnabled: true));
    await tester.pumpWidget(build(isEnabled: false));

    expect(builds, 2);
  });
}
