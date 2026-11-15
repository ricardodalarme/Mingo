import 'package:app/features/mood/presentation/mood/widgets/partner_mood_listen_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  double top(WidgetTester tester, String text) => tester.getTopLeft(find.text(text)).dy;

  testWidgets('lists listening first, then love, then how to help', (tester) async {
    await tester.pumpApp(const PartnerMoodListenSheet());
    await tester.pump();

    expect(top(tester, 'Perguntar se quer conversar'), lessThan(top(tester, 'Mandar um carinho')));
    expect(top(tester, 'Mandar um carinho'), lessThan(top(tester, 'Ver como ajudar')));
  });

  testWidgets('choosing love closes the sheet with that action', (tester) async {
    PartnerMoodListenAction? chosen;
    await tester.pumpApp(
      Builder(
        builder: (context) => BaseButton(
          text: 'Abrir',
          onPressed: () async {
            chosen = await BaseSheet.show<PartnerMoodListenAction>(
              context: context,
              title: 'Escuta primeiro',
              child: const PartnerMoodListenSheet(),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mandar um carinho'));
    await tester.pumpAndSettle();

    expect(chosen, PartnerMoodListenAction.sendLove);
  });

  testWidgets('choosing how to help closes the sheet with that action', (tester) async {
    PartnerMoodListenAction? chosen;
    await tester.pumpApp(
      Builder(
        builder: (context) => BaseButton(
          text: 'Abrir',
          onPressed: () async {
            chosen = await BaseSheet.show<PartnerMoodListenAction>(
              context: context,
              title: 'Escuta primeiro',
              child: const PartnerMoodListenSheet(),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ver como ajudar'));
    await tester.pumpAndSettle();

    expect(chosen, PartnerMoodListenAction.seeHowToHelp);
  });
}
