import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show Scaffold;

import '../../../helpers/widget_host.dart';

Widget _host(Widget child, {AppThemeVariant variant = AppThemeVariant.rose}) {
  return appFor(
    variant: variant,
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('a tap opens the dark bubble with the message for ${variant.name}', (tester) async {
      setSurface(tester);
      await tester.pumpWidget(
        _host(
          const BaseTooltip(
            message: 'Only you see this slip until Sunday.',
            trigger: BaseTooltipTrigger.tap,
            child: SizedBox(key: Key('anchor'), width: 44, height: 44),
          ),
          variant: variant,
        ),
      );

      await tester.tap(find.byKey(const Key('anchor')));
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Only you see this slip until Sunday.'), findsOneWidget);
      final bubble = tester.widget<Container>(
        find
            .ancestor(
              of: find.text('Only you see this slip until Sunday.'),
              matching: find.byType(Container),
            )
            .first,
      );
      expect((bubble.decoration! as BoxDecoration).color, AppPalette.neutral900);
      final text = tester.widget<Text>(find.text('Only you see this slip until Sunday.'));
      expect(text.style!.color, AppPalette.white);
      expect(text.maxLines, 2);

      await tester.pump(const Duration(seconds: 5));
    });
  }

  testWidgets('it opens above the anchor with the arrow pointing at it', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      _host(
        const BaseTooltip(
          message: 'Info',
          trigger: BaseTooltipTrigger.tap,
          child: SizedBox(key: Key('anchor'), width: 44, height: 44),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('anchor')));
    await tester.pump(const Duration(milliseconds: 200));

    final anchor = tester.getRect(find.byKey(const Key('anchor')));
    final bubble = tester.getRect(find.text('Info'));
    expect(bubble.bottom, lessThan(anchor.top));
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('it opens below when there is no room above', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      appFor(
        variant: AppThemeVariant.rose,
        home: const Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: BaseTooltip(
              message: 'Info',
              trigger: BaseTooltipTrigger.tap,
              child: SizedBox(key: Key('anchor'), width: 44, height: 44),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('anchor')));
    await tester.pump(const Duration(milliseconds: 200));

    expect(
      tester.getRect(find.text('Info')).top,
      greaterThan(tester.getRect(find.byKey(const Key('anchor'))).bottom),
    );
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('a long press opens it after 400 ms and a plain tap does not', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      _host(
        const BaseTooltip(
          message: 'Settings',
          child: SizedBox(key: Key('anchor'), width: 44, height: 44),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('anchor')));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Settings'), findsNothing);

    final gesture = await tester.startGesture(tester.getCenter(find.byKey(const Key('anchor'))));
    await tester.pump(const Duration(milliseconds: 450));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Settings'), findsOneWidget);
    await gesture.up();
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('a tap anywhere closes it and it closes after four seconds', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      _host(
        const BaseTooltip(
          message: 'Info',
          trigger: BaseTooltipTrigger.tap,
          child: SizedBox(key: Key('anchor'), width: 44, height: 44),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('anchor')));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Info'), findsOneWidget);
    await tester.tapAt(const Offset(10, 10));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Info'), findsNothing);

    await tester.tap(find.byKey(const Key('anchor')));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Info'), findsOneWidget);
    await tester.pump(const Duration(seconds: 4, milliseconds: 100));
    expect(find.text('Info'), findsNothing);
  });

  testWidgets('only one tooltip is open at a time', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      _host(
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseTooltip(
              message: 'First',
              trigger: BaseTooltipTrigger.tap,
              child: SizedBox(key: Key('a'), width: 44, height: 44),
            ),
            SizedBox(width: 40),
            BaseTooltip(
              message: 'Second',
              trigger: BaseTooltipTrigger.tap,
              child: SizedBox(key: Key('b'), width: 44, height: 44),
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('a')));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.byKey(const Key('b')));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('First'), findsNothing);
    expect(find.text('Second'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('the message is the accessibility hint of the anchor', (tester) async {
    setSurface(tester);
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      _host(
        const BaseTooltip(
          message: 'Counts the days',
          child: SizedBox(key: Key('anchor'), width: 44, height: 44),
        ),
      ),
    );

    expect(tester.getSemantics(find.byKey(const Key('anchor'))).tooltip, 'Counts the days');
    semantics.dispose();
  });
}
