import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_mood_help_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  double top(WidgetTester tester, String text) => tester.getTopLeft(find.text(text)).dy;

  testWidgets('a tired partner sees the chore before the question', (tester) async {
    await tester.pumpApp(const PartnerMoodHelpSheet(mood: MoodKind.tired));
    await tester.pump();

    expect(
      top(tester, 'Assumir uma tarefa'),
      lessThan(top(tester, 'Perguntar: quer ouvir ou espaço?')),
    );
    expect(
      top(tester, 'Perguntar: quer ouvir ou espaço?'),
      lessThan(top(tester, 'Mandar uma mensagem curta e carinhosa')),
    );
    expect(
      top(tester, 'Mandar uma mensagem curta e carinhosa'),
      lessThan(top(tester, 'Fazer café ou o jantar')),
    );
  });

  testWidgets('a stressed partner sees the question first and the chore second', (tester) async {
    await tester.pumpApp(const PartnerMoodHelpSheet(mood: MoodKind.stressed));
    await tester.pump();

    expect(
      top(tester, 'Perguntar: quer ouvir ou espaço?'),
      lessThan(top(tester, 'Assumir uma tarefa')),
    );
    expect(
      top(tester, 'Assumir uma tarefa'),
      lessThan(top(tester, 'Mandar uma mensagem curta e carinhosa')),
    );
    expect(
      top(tester, 'Mandar uma mensagem curta e carinhosa'),
      lessThan(top(tester, 'Fazer café ou o jantar')),
    );
  });

  testWidgets('the four options are all there', (tester) async {
    await tester.pumpApp(const PartnerMoodHelpSheet(mood: MoodKind.tired));
    await tester.pump();

    for (final text in [
      'Assumir uma tarefa',
      'Perguntar: quer ouvir ou espaço?',
      'Mandar uma mensagem curta e carinhosa',
      'Fazer café ou o jantar',
    ]) {
      expect(find.text(text), findsOneWidget);
    }
  });
}
