import 'package:design_system/design_system.dart';
import 'package:design_system/src/components/surfaces/face_animations.dart';
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

    expect(requests.map((request) => request.clip), everyElement(FaceClip.idle));
    expect(requests.last.startOffset, inInclusiveRange(0, 1));
  });

  testWidgets('a showcase face enters once and then idles', (tester) async {
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.smile, size: FaceSize.showcase)),
    );

    expect(requests.last.clip, FaceClip.enter);

    requests.last.onCompleted();
    await tester.pump();

    expect(requests.last.clip, FaceClip.idle);
    expect(requests.last.startOffset, 0);
  });

  testWidgets('becoming selected pops once and returns to idle', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good)));
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));

    expect(requests.last.clip, FaceClip.pop);

    requests.last.onCompleted();
    await tester.pump();

    expect(requests.last.clip, FaceClip.idle);

    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));

    expect(requests.last.clip, FaceClip.idle);
  });

  testWidgets('selecting again after a clear pops again', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good)));
    requests.clear();

    expect(find.byType(SvgPicture), findsOneWidget);

    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, selected: true)));

    expect(requests.first.clip, FaceClip.pop);
  });

  testWidgets('a new pop token pops an animated face', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, motion: FaceMotion.idle)));

    expect(requests.last.clip, FaceClip.idle);

    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.good, motion: FaceMotion.idle, popToken: 1)),
    );

    expect(requests.last.clip, FaceClip.pop);
  });

  testWidgets('an explicit motion does not pop when it becomes selected', (tester) async {
    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.good, motion: FaceMotion.idle)));
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.good, motion: FaceMotion.idle, selected: true)),
    );

    expect(requests.map((request) => request.clip), everyElement(FaceClip.idle));
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

  testWidgets('changing the kind restarts the animation from its start', (tester) async {
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.good, motion: FaceMotion.enter)),
    );
    requests.last.onCompleted();
    await tester.pump();

    await tester.pumpWidget(animated(const BaseFace(kind: FaceKind.sad, motion: FaceMotion.enter)));

    expect(requests.last.kind, FaceKind.sad);
    expect(requests.last.clip, FaceClip.enter);
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

  testWidgets('pauses in the background and restarts idle on resume', (tester) async {
    await tester.pumpWidget(
      animated(const BaseFace(kind: FaceKind.smile, size: FaceSize.showcase)),
    );

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    await tester.pump();

    expect(requests.last.isPaused, isTrue);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();

    expect(requests.last.isPaused, isFalse);
    expect(requests.last.clip, FaceClip.idle);
  });

  testWidgets('renders the static face once when the animations are not loaded', (tester) async {
    FaceAnimations.reset();
    final messages = <String?>[];
    final original = debugPrint;
    debugPrint = (message, {wrapWidth}) => messages.add(message);
    addTearDown(() => debugPrint = original);

    await tester.pumpWidget(
      themedHost(
        const FaceMotionScope(
          child: Column(
            children: [
              BaseFace(kind: FaceKind.good, selected: true),
              BaseFace(kind: FaceKind.sad, selected: true),
            ],
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(SvgPicture), findsNWidgets(2));
    expect(messages, hasLength(1));
  });
}
