import 'package:design_system/design_system.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/widget_host.dart';

const _anchor = Rect.fromLTWH(172, 760, 46, 46);

const _slip = BaseMenuItem(id: 'slip', icon: AppIcons.note, label: 'Write a slip', isPrimary: true);
const _need = BaseMenuItem(id: 'need', icon: AppIcons.heart, label: 'I need…');
const _note = BaseMenuItem(id: 'note', icon: AppIcons.send, label: 'Send a note');
const _memory = BaseMenuItem(id: 'memory', icon: AppIcons.bookmark, label: 'Save a memory');

Widget _host(Widget child, {double textScale = 1, bool reduceMotion = false}) {
  return MaterialApp(
    theme: AppTheme.light(AppThemeVariant.rose),
    builder: (context, navChild) => MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(disableAnimations: reduceMotion, textScaler: TextScaler.linear(textScale)),
      child: uiLocalized(navChild!),
    ),
    home: Scaffold(body: child),
  );
}

class _Result() {
  bool isDone = false;
  BaseMenuItem? item;
}

class const _Launcher({required final List<BaseMenuItem> items, required final _Result result})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        key: const ValueKey('open'),
        onTap: () async {
          final item = await showBaseMenu(context, anchor: _anchor, items: items);
          result
            ..item = item
            ..isDone = true;
        },
        child: const SizedBox(width: 80, height: 40, child: Text('open')),
      ),
    );
  }
}

Future<_Result> _open(
  WidgetTester tester, {
  List<BaseMenuItem> items = const [_slip, _need, _note],
  double textScale = 1,
  bool reduceMotion = false,
}) async {
  setSurface(tester);
  final result = _Result();
  await tester.pumpWidget(
    _host(
      _Launcher(items: items, result: result),
      textScale: textScale,
      reduceMotion: reduceMotion,
    ),
  );
  await tester.tap(find.byKey(const ValueKey('open')));
  await tester.pumpAndSettle();

  return result;
}

void main() {
  for (final items in [
    [_slip, _need],
    [_slip, _need, _note],
    [_slip, _need, _note, _memory],
  ]) {
    testWidgets('renders ${items.length} rows and ${items.length - 1} dividers', (tester) async {
      await _open(tester, items: items);

      for (final item in items) {
        expect(find.byKey(ValueKey('baseMenuItem-${item.id}')), findsOneWidget);
        expect(find.text(item.label), findsOneWidget);
      }
      expect(find.byKey(const ValueKey('baseMenuDivider')), findsNWidgets(items.length - 1));
    });
  }

  testWidgets('only the primary row is weight 600', (tester) async {
    await _open(tester);

    FontWeight? weightOf(String text) => tester.widget<Text>(find.text(text)).style?.fontWeight;

    expect(weightOf('Write a slip'), FontWeight.w600);
    expect(weightOf('I need…'), FontWeight.w500);
  });

  testWidgets('a row is 54 high and the card is 250 wide on a 390 screen', (tester) async {
    await _open(
      tester,
      items: const [
        BaseMenuItem(id: 'slip', icon: AppIcons.note, label: 'Slip', isPrimary: true),
        _need,
      ],
    );

    final row = tester.getSize(find.byKey(const ValueKey('baseMenuItem-slip')));

    expect(row.height, 54);
    expect(row.width, 250);
  });

  testWidgets('the tail points at the centre of the anchor', (tester) async {
    await _open(tester);

    expect(tester.getCenter(find.byKey(const ValueKey('baseMenuTail'))).dx, _anchor.center.dx);
    expect(
      tester.getBottomLeft(find.byKey(const ValueKey('baseMenuItem-note'))).dy,
      lessThanOrEqualTo(_anchor.top - 32 + .5),
    );
  });

  testWidgets('tapping a row closes the menu, then returns the item', (tester) async {
    final result = await _open(tester);

    await tester.tap(find.byKey(const ValueKey('baseMenuItem-need')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('baseMenuItem-need')), findsNothing);
    expect(result.isDone, isTrue);
    expect(result.item, _need);
  });

  testWidgets('tapping the scrim returns null', (tester) async {
    final result = await _open(tester);

    await tester.tapAt(const Offset(20, 100));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('baseMenuItem-need')), findsNothing);
    expect(result.isDone, isTrue);
    expect(result.item, isNull);
  });

  testWidgets('the system back returns null', (tester) async {
    final result = await _open(tester);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('baseMenuItem-need')), findsNothing);
    expect(result.isDone, isTrue);
    expect(result.item, isNull);
  });

  testWidgets('escape returns null', (tester) async {
    final result = await _open(tester);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    expect(result.isDone, isTrue);
    expect(result.item, isNull);
  });

  testWidgets('the scrim carries the localized close label', (tester) async {
    await _open(tester);

    expect(find.bySemanticsLabel('Close'), findsOneWidget);
  });

  testWidgets('focus moves to the first row on open', (tester) async {
    await _open(tester);

    final focused = FocusManager.instance.primaryFocus?.context;

    expect(
      focused?.findAncestorWidgetOfExactType<AppPressable>()?.key,
      const ValueKey('baseMenuItem-slip'),
    );
  });

  testWidgets('opening scales the card up from 0.92', (tester) async {
    setSurface(tester);
    final result = _Result();
    await tester.pumpWidget(_host(_Launcher(items: const [_slip, _need], result: result)));
    await tester.tap(find.byKey(const ValueKey('open')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 40));

    final scale = tester
        .widget<ScaleTransition>(find.byKey(const ValueKey('baseMenuScale')))
        .scale
        .value;

    expect(scale, lessThan(1));
    expect(scale, greaterThanOrEqualTo(.92));
    await tester.pumpAndSettle();
  });

  testWidgets('reduced motion renders no scale transition', (tester) async {
    await _open(tester, reduceMotion: true);

    expect(find.byKey(const ValueKey('baseMenuScale')), findsNothing);
  });

  testWidgets('asserts for fewer than 2 or more than 4 items', (tester) async {
    BaseMenu build(List<BaseMenuItem> items) =>
        BaseMenu(items: items, anchor: _anchor, onSelect: (_) {}, onDismiss: () {});

    expect(() => build(const [_slip]), throwsAssertionError);
    expect(() => build(const [_slip, _need, _note, _memory, _slip]), throwsAssertionError);
  });

  testWidgets('text scale 2.0 grows the rows and does not overflow', (tester) async {
    await _open(tester, items: const [_slip, _need, _note, _memory], textScale: 2);

    expect(tester.takeException(), isNull);
    expect(tester.getSize(find.byKey(const ValueKey('baseMenuItem-slip'))).height, greaterThan(54));
    expect(
      tester.getSize(find.byKey(const ValueKey('baseMenuItem-slip'))).width,
      lessThanOrEqualTo(390 - 32),
    );
  });
}
