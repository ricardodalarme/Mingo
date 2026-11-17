import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  late List<FacePlayerRequest> requests;

  setUp(() => requests = []);

  Widget animated(Widget face, {bool reduceMotion = false, bool isEnabled = true}) {
    return themedHost(
      Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
          child: FaceMotionScope(
            enabled: isEnabled,
            playerBuilder: (context, request) {
              requests.add(request);
              return const SizedBox.shrink();
            },
            child: face,
          ),
        ),
      ),
    );
  }

  testWidgets('renders a face', (tester) async {
    await tester.pumpWidget(themedHost(const BaseFace(kind: FaceKind.affectionate)));

    expect(find.byType(BaseFace), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps the semantic label', (tester) async {
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.good, selected: true, semanticLabel: 'Good')),
    );

    expect(find.bySemanticsLabel('Good'), findsOneWidget);
  });

  testWidgets('an unselected small face stays still', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good)));

    expect(requests, isEmpty);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('a selected face idles without a pop on the first build', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));

    expect(requests.last.motion, FaceMotion.idle);
    expect(requests.last.popToken, 0);
  });

  testWidgets('a showcase face enters', (tester) async {
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.smile, size: FaceSize.showcase)),
    );

    expect(requests.last.motion, FaceMotion.enter);
    expect(requests.last.popToken, 0);
  });

  testWidgets('becoming selected pops when the animation starts', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good)));
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));

    expect(requests.last.motion, FaceMotion.idle);
    expect(requests.last.popToken, greaterThan(0));

    final token = requests.last.popToken;
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));

    expect(requests.last.popToken, token);
  });

  testWidgets('selecting again after a clear pops again', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good)));
    requests.clear();

    expect(find.byType(SvgPicture), findsOneWidget);

    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));

    expect(requests.first.popToken, greaterThan(0));
  });

  testWidgets('selecting another kind while selected pops the same face', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.sad, selected: true)));

    expect(requests.last.kind, FaceKind.sad);
    expect(requests.last.popToken, 0);
  });

  testWidgets('a new pop token reaches an animated face', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, motion: FaceMotion.idle)));

    expect(requests.last.popToken, 0);

    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.good, motion: FaceMotion.idle, popToken: 1)),
    );

    expect(requests.last.popToken, greaterThan(0));
  });

  testWidgets('an explicit motion does not pop when it becomes selected', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, motion: FaceMotion.idle)));
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.good, motion: FaceMotion.idle, selected: true)),
    );

    expect(requests.last.popToken, 0);
  });

  testWidgets('an explicit still ignores selection', (tester) async {
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.good, selected: true, motion: FaceMotion.still)),
    );

    expect(requests, isEmpty);
  });

  testWidgets('reduced motion renders still and ignores the pop token', (tester) async {
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.good, selected: true), reduceMotion: true),
    );
    await tester.pumpWidget(
      animated(
        const BaseFace(kind: FaceKind.good, selected: true, popToken: 1),
        reduceMotion: true,
      ),
    );

    expect(requests, isEmpty);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('a disabled scope renders still', (tester) async {
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.good, selected: true), isEnabled: false),
    );

    expect(requests, isEmpty);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('pauses while the ticker mode is off', (tester) async {
    await tester.pumpWidget(
      themedHost(
        TickerMode(
          enabled: false,
          child: FaceMotionScope(
            playerBuilder: (context, request) {
              requests.add(request);
              return const SizedBox.shrink();
            },
            child: const BaseFace(kind: FaceKind.good, selected: true),
          ),
        ),
      ),
    );

    expect(requests.last.isPaused, isTrue);
  });

  testWidgets('pauses in the background and resumes in the foreground', (tester) async {
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.smile, size: FaceSize.showcase)),
    );

    expect(requests.last.isPaused, isFalse);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    await tester.pump();

    expect(requests.last.isPaused, isTrue);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    expect(requests.last.isPaused, isFalse);
  });
}
