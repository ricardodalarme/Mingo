import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_need_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('names the need and the one thing that answers it', (tester) async {
    await tester.pumpApp(const PartnerNeedSheet(need: NeedKind.chocolate));
    await tester.pump();

    expect(find.text('UM CHOCOLATE'), findsOneWidget);
    expect(find.text('Levar um chocolate'), findsOneWidget);
    expect(find.text('Um chocolate pequeno, sem motivo.'), findsOneWidget);
  });

  testWidgets('a hug is tappable and closes the sheet with the answer', (tester) async {
    PartnerNeedAnswer? chosen;
    await tester.pumpApp(
      Builder(
        builder: (context) => BaseButton(
          text: 'Abrir',
          onPressed: () async {
            chosen = await BaseSheet.show<PartnerNeedAnswer>(
              context: context,
              title: 'O que Marina precisa',
              child: const PartnerNeedSheet(need: NeedKind.hug),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mandar um abraço'));
    await tester.pumpAndSettle();

    expect(chosen, PartnerNeedAnswer.hug);
  });

  testWidgets('a cute message opens the conversation', (tester) async {
    PartnerNeedAnswer? chosen;
    await tester.pumpApp(
      Builder(
        builder: (context) => BaseButton(
          text: 'Abrir',
          onPressed: () async {
            chosen = await BaseSheet.show<PartnerNeedAnswer>(
              context: context,
              title: 'O que Marina precisa',
              child: const PartnerNeedSheet(need: NeedKind.cuteMessage),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Abrir a conversa'));
    await tester.pumpAndSettle();

    expect(chosen, PartnerNeedAnswer.chat);
  });

  testWidgets('guidance does not look tappable', (tester) async {
    await tester.pumpApp(const PartnerNeedSheet(need: NeedKind.rest));
    await tester.pump();

    expect(tester.widget<BaseListCard>(find.byType(BaseListCard)).onTap, isNull);
    expect(find.byIcon(AppIcons.chevron_right), findsNothing);
  });
}
