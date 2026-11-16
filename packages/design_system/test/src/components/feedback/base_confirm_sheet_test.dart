import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/widget_host.dart';

Widget _localizationFreeHost(Widget child) {
  return AppThemed(
    variant: AppThemeVariant.rose,
    child: MediaQuery(
      data: const MediaQueryData(size: Size(390, 844)),
      child: Directionality(textDirection: TextDirection.ltr, child: child),
    ),
  );
}

class const _Launcher({
  required final ValueChanged<Future<bool>> onResult,
  final bool isDestructive = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () => onResult(
            BaseConfirmSheet.show(
              context: context,
              title: 'Delete this slip?',
              text: 'It leaves this week.',
              confirmText: 'Delete slip',
              isDestructive: isDestructive,
            ),
          ),
          child: const Text('open'),
        ),
      ),
    );
  }
}

Future<void> _open(
  WidgetTester tester,
  AppThemeVariant variant, {
  bool isDestructive = true,
}) async {
  setSurface(tester);
  await tester.pumpWidget(
    appFor(
      variant: variant,
      home: _Launcher(onResult: (_) {}, isDestructive: isDestructive),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('shows the handle, a filled error verb and a text cancel for ${variant.name}', (
      tester,
    ) async {
      await _open(tester, variant);

      final verb = find.ancestor(of: find.text('Delete slip'), matching: find.byType(BaseButton));
      expect(tester.widget<BaseButton>(verb.first).variant, BaseButtonVariant.danger);
      final cancel = find.ancestor(of: find.text('Cancel'), matching: find.byType(BaseButton));
      expect(tester.widget<BaseButton>(cancel.first).variant, BaseButtonVariant.text);
      expect(find.byType(BaseSheet), findsOneWidget);
      expect(find.byType(BaseRoundButton), findsNothing);
      expect(find.text('It leaves this week.'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a neutral confirmation uses the primary button for ${variant.name}', (
      tester,
    ) async {
      await _open(tester, variant, isDestructive: false);

      final verb = find.ancestor(of: find.text('Delete slip'), matching: find.byType(BaseButton));
      expect(tester.widget<BaseButton>(verb.first).variant, BaseButtonVariant.primary);
    });
  }

  testWidgets('confirm resolves true and runs onConfirm first', (tester) async {
    setSurface(tester);
    late Future<bool> pending;
    var ran = false;
    await tester.pumpWidget(
      appFor(
        variant: AppThemeVariant.rose,
        home: Scaffold(
          body: Builder(
            builder: (context) => GestureDetector(
              onTap: () => pending = BaseConfirmSheet.show(
                context: context,
                title: 'Delete?',
                text: 'Gone.',
                confirmText: 'Delete',
                onConfirm: () => ran = true,
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(await pending, isTrue);
    expect(ran, isTrue);
    expect(find.text('Delete?'), findsNothing);
  });

  testWidgets('cancel and a scrim tap resolve false', (tester) async {
    setSurface(tester);
    late Future<bool> pending;
    await tester.pumpWidget(
      appFor(
        variant: AppThemeVariant.rose,
        home: _Launcher(onResult: (value) => pending = value),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(await pending, isFalse);

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(195, 60));
    await tester.pumpAndSettle();
    expect(await pending, isFalse);
  });

  testWidgets('the confirm sheet opens without ancestor localizations', (tester) async {
    bool? confirmed;

    await tester.pumpWidget(
      _localizationFreeHost(
        Navigator(
          onGenerateRoute: (_) => PageRouteBuilder<void>(
            pageBuilder: (context, animation, secondaryAnimation) => Builder(
              builder: (context) => BaseButton.primary(
                text: 'Delete',
                onPressed: () async {
                  confirmed = await BaseConfirmSheet.show(
                    context: context,
                    title: 'Delete this slip?',
                    text: 'It leaves this week.',
                    confirmText: 'Delete slip',
                    isDestructive: true,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Delete this slip?'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Delete slip'));
    await tester.pumpAndSettle();

    expect(confirmed, isTrue);
  });
}
