import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(
  AppThemeVariant variant,
  Widget child, {
  double textScale = 1,
  bool disableAnimations = false,
}) {
  return AppThemeHost(
    initialVariant: variant,
    child: MediaQuery(
      data: MediaQueryData(
        textScaler: TextScaler.linear(textScale),
        disableAnimations: disableAnimations,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 390,
            child: SingleChildScrollView(padding: const EdgeInsets.all(AppSpace.s20), child: child),
          ),
        ),
      ),
    ),
  );
}

Widget _showcase() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      BaseListCard(
        categoryLabel: 'Idea of the day',
        title: 'Leave a note inside his backpack.',
        supportText: '2 minutes · free',
        face: FaceKind.smile,
        onTap: () {},
      ),
      const SizedBox(height: AppSpace.cardGap),
      BaseListCard(
        categoryLabel: 'Anniversary',
        title: 'Faltam 12 dias.',
        category: AppCategory.dates,
        supportText: 'Want gift ideas?',
        trailing: const BaseTag(text: 'Open'),
        onTap: () {},
      ),
      const SizedBox(height: AppSpace.cardGap),
      BaseListCard(
        categoryLabel: 'Invite',
        title: 'Your space already works. The other person joins whenever.',
        category: AppCategory.invite,
        face: FaceKind.smile,
        onTap: () {},
      ),
      const SizedBox(height: AppSpace.cardGap),
      BaseListCard(
        categoryLabel: 'Reminder',
        icon: AppIcons.bell,
        title: 'One quiet reminder.',
        onTap: () {},
      ),
    ],
  );
}

const _title = 'Leave a note inside his backpack.';
const _support = '2 minutes · free';

Widget _oneCard({VoidCallback? onTap, Widget? trailing}) {
  return BaseListCard(
    categoryLabel: 'Idea of the day',
    title: _title,
    supportText: _support,
    trailing: trailing,
    onTap: onTap,
  );
}

Finder _inCard(Finder matching) =>
    find.descendant(of: find.byType(BaseListCard), matching: matching);

Rect _textColumn(WidgetTester tester) => tester.getRect(_inCard(find.byType(Expanded)));

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('renders every list card in ${variant.name}', (tester) async {
      await tester.pumpWidget(_host(variant, _showcase()));

      expect(find.byType(BaseListCard), findsNWidgets(4));
      expect(find.text('Faltam 12 dias.'), findsOneWidget);
      expect(find.text('IDEA OF THE DAY'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('the default card hides the category glyph in ${variant.name}', (tester) async {
      await tester.pumpWidget(_host(variant, _showcase()));

      expect(find.byIcon(AppIcons.mail), findsNothing);
      expect(find.byIcon(AppIcons.calendar), findsOneWidget);
      expect(find.byIcon(AppIcons.user_filled), findsOneWidget);
      expect(find.byIcon(AppIcons.bell), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('list cards grow at 200% text scale in ${variant.name}', (tester) async {
      await tester.pumpWidget(_host(variant, _showcase(), textScale: 2));

      expect(find.byType(BaseListCard), findsNWidgets(4));
      expect(tester.takeException(), isNull);
    });
  }

  group('disclosure', () {
    testWidgets('a tappable card shows the chevron and fires onTap', (tester) async {
      var taps = 0;
      await tester.pumpWidget(_host(AppThemeVariant.rose, _oneCard(onTap: () => taps++)));

      expect(find.byIcon(AppIcons.chevron_right), findsOneWidget);

      await tester.tap(find.byType(BaseListCard));
      expect(taps, 1);
    });

    testWidgets('a card without onTap shows no chevron and no press feedback', (tester) async {
      await tester.pumpWidget(_host(AppThemeVariant.rose, _oneCard()));

      expect(find.byIcon(AppIcons.chevron_right), findsNothing);

      final gesture = await tester.startGesture(tester.getCenter(find.byType(BaseListCard)));
      await tester.pump();

      expect(tester.widget<AnimatedScale>(_inCard(find.byType(AnimatedScale))).scale, 1);

      await gesture.up();
    });

    testWidgets('the card reserves the chevron slot only when tappable', (tester) async {
      await tester.pumpWidget(_host(AppThemeVariant.rose, _oneCard(onTap: () {})));
      final tappable = _textColumn(tester);
      final tappableCard = tester.getRect(find.byType(BaseListCard));

      await tester.pumpWidget(_host(AppThemeVariant.rose, _oneCard()));
      final plain = _textColumn(tester);
      final plainCard = tester.getRect(find.byType(BaseListCard));

      expect(plain.left, closeTo(tappable.left, .5));
      expect(plain.right - tappable.right, closeTo(AppSpace.s8 + AppIconSize.md, .5));
      expect(tappableCard.width, plainCard.width);
    });

    testWidgets('the chevron sits after the trailing visual, inside the card padding', (
      tester,
    ) async {
      await tester.pumpWidget(
        _host(
          AppThemeVariant.rose,
          _oneCard(
            onTap: () {},
            trailing: const BaseTag(text: 'Open'),
          ),
        ),
      );

      final card = tester.getRect(find.byType(BaseListCard));
      final tag = tester.getRect(find.byType(BaseTag));
      final chevron = tester.getRect(find.byIcon(AppIcons.chevron_right));

      expect(chevron.left - tag.right, closeTo(AppSpace.s8, .5));
      expect(card.right - chevron.right, closeTo(AppSpace.s18, .5));
      expect(chevron.center.dy, closeTo(tag.center.dy, .5));
    });

    testWidgets('a tappable card reads as one button with its label', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(_host(AppThemeVariant.rose, _oneCard(onTap: () {})));

      final node = tester.getSemantics(find.byType(BaseListCard));

      expect(node.flagsCollection.isButton, isTrue);
      expect(node.label, contains(_title));
      expect(node.label, contains(_support));
      expect(find.bySemanticsLabel(RegExp(_title)), findsOneWidget);

      handle.dispose();
    });

    testWidgets('a card without onTap keeps its label and is not a button', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(_host(AppThemeVariant.rose, _oneCard()));

      final node = tester.getSemantics(find.byType(BaseListCard));

      expect(node.flagsCollection.isButton, isFalse);
      expect(node.label, contains(_title));

      handle.dispose();
    });

    testWidgets('a pressed card scales, and reduced motion keeps it still', (tester) async {
      await tester.pumpWidget(_host(AppThemeVariant.rose, _oneCard(onTap: () {})));

      final gesture = await tester.startGesture(tester.getCenter(find.byType(BaseListCard)));
      await tester.pump();

      expect(
        tester.widget<AnimatedScale>(_inCard(find.byType(AnimatedScale))).scale,
        AppMotion.pressedScale,
      );

      await gesture.up();
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        _host(AppThemeVariant.rose, _oneCard(onTap: () {}), disableAnimations: true),
      );

      final still = await tester.startGesture(tester.getCenter(find.byType(BaseListCard)));
      await tester.pump();

      expect(tester.widget<AnimatedScale>(_inCard(find.byType(AnimatedScale))).scale, 1);

      await still.up();
    });
  });
}
