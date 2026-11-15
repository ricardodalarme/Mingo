import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/share_image_entry.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/today_share_entry.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  TodayHome homeWith({DateTime? togetherSince}) => TodayHome(
    isPaired: true,
    unopenedCards: 0,
    slipsThisWeek: 2,
    slipsTotal: 2,
    hasPendingInvite: false,
    hasPlus: false,
    partnerName: 'Rui',
    togetherSince: togetherSince,
  );

  testWidgets('stays hidden while the couple has no start date', (tester) async {
    await tester.pumpApp(Center(child: TodayShareEntry(home: homeWith())));

    expect(find.byType(ShareImageEntry), findsNothing);
    expect(find.text('Compartilhar imagem'), findsNothing);
  });

  testWidgets('offers the counter and the moon of the start date', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 11, 15, 12)), () async {
      await tester.pumpApp(
        Center(child: TodayShareEntry(home: homeWith(togetherSince: DateTime(2024, 3, 14)))),
      );

      expect(find.text('Compartilhar imagem'), findsOneWidget);
      expect(
        find.text('O tempo de vocês e a lua do dia em que tudo começou.'),
        findsOneWidget,
      );

      final entry = tester.widget<ShareImageEntry>(find.byType(ShareImageEntry));
      expect(entry.cards.map((card) => card.kind), [
        ShareCardKind.counter,
        ShareCardKind.moon,
      ]);
      expect(find.byType(BaseListGroup), findsOneWidget);
    });
  });

  testWidgets('a start date in the future is not counted', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 11, 15, 12)), () async {
      await tester.pumpApp(
        Center(child: TodayShareEntry(home: homeWith(togetherSince: DateTime(2027, 1, 1)))),
      );

      expect(find.byType(ShareImageEntry), findsNothing);
    });
  });
}
