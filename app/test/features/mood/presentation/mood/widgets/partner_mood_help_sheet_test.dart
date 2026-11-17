import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_mood_help_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  double top(WidgetTester tester, String text) => tester.getTopLeft(find.text(text)).dy;

  const message = 'Mandar uma mensagem curta e carinhosa';

  testWidgets('a tired partner sees the chore before the question', (tester) async {
    await tester.pumpApp(const PartnerMoodHelpSheet(mood: MoodKind.tired));
    await tester.pump();

    expect(
      top(tester, 'Assumir uma tarefa'),
      lessThan(top(tester, 'Perguntar: quer ouvir ou espaço?')),
    );
    expect(top(tester, 'Perguntar: quer ouvir ou espaço?'), lessThan(top(tester, message)));
    expect(top(tester, message), lessThan(top(tester, 'Fazer café ou o jantar')));
  });

  testWidgets('a stressed partner sees the question first and the chore second', (tester) async {
    await tester.pumpApp(const PartnerMoodHelpSheet(mood: MoodKind.stressed));
    await tester.pump();

    expect(
      top(tester, 'Perguntar: quer ouvir ou espaço?'),
      lessThan(top(tester, 'Assumir uma tarefa')),
    );
    expect(top(tester, 'Assumir uma tarefa'), lessThan(top(tester, message)));
    expect(top(tester, message), lessThan(top(tester, 'Fazer café ou o jantar')));
  });

  testWidgets('the four options are all there', (tester) async {
    await tester.pumpApp(const PartnerMoodHelpSheet(mood: MoodKind.tired));
    await tester.pump();

    for (final text in [
      'Assumir uma tarefa',
      'Perguntar: quer ouvir ou espaço?',
      message,
      'Fazer café ou o jantar',
    ]) {
      expect(find.text(text), findsOneWidget);
    }
  });

  testWidgets('the sheet says the ideas are not a diagnosis', (tester) async {
    await tester.pumpApp(const PartnerMoodHelpSheet(mood: MoodKind.tired));
    await tester.pump();

    expect(find.text('Sugestões do app, sem diagnóstico. Sem pressa.'), findsOneWidget);
  });

  testWidgets('only the message is a card; the real-world acts are suggestions', (tester) async {
    await tester.pumpApp(const PartnerMoodHelpSheet(mood: MoodKind.tired));
    await tester.pump();

    expect(find.byType(BaseListCard), findsOneWidget);
    for (final text in [
      'Assumir uma tarefa',
      'Perguntar: quer ouvir ou espaço?',
      'Fazer café ou o jantar',
    ]) {
      expect(find.ancestor(of: find.text(text), matching: find.byType(AppPressable)), findsNothing);
    }
    expect(
      find.ancestor(of: find.text(message), matching: find.byType(BaseListCard)),
      findsOneWidget,
    );
  });

  testWidgets('the message closes the sheet with its action', (tester) async {
    PartnerMoodHelpAction? chosen;
    await tester.pumpApp(
      Builder(
        builder: (context) => BaseButton(
          text: 'Abrir',
          onPressed: () async {
            chosen = await BaseSheet.show<PartnerMoodHelpAction>(
              context: context,
              title: 'Como ajudar hoje',
              child: const PartnerMoodHelpSheet(mood: MoodKind.stressed),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(message));
    await tester.pumpAndSettle();

    expect(chosen, PartnerMoodHelpAction.sendMessage);
  });
}
