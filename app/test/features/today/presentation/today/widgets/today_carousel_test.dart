import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/today_carousel.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

TodayHome _home({
  bool isPaired = true,
  int unopenedCards = 0,
  int slipsThisWeek = 0,
  bool hasPendingInvite = false,
}) => TodayHome(
  isPaired: isPaired,
  unopenedCards: unopenedCards,
  slipsThisWeek: slipsThisWeek,
  slipsTotal: slipsThisWeek,
  hasPendingInvite: hasPendingInvite,
  hasPlus: false,
  partnerName: 'Luanna',
  idea: const Suggestion(slug: 'ideia', title: 'Deixe um bilhete', body: 'Pequeno e grátis.'),
);

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('on your own it offers the private prompt, the invite and the idea', (tester) async {
    await tester.pumpApp(TodayCarousel(home: _home(isPaired: false), isSoloOnly: false));
    await tester.pumpAndSettle();

    expect(find.text('SÓ SEU'), findsWidgets);
    expect(find.text('CONVITE'), findsWidgets);
    expect(find.text('IDEIA DO DIA'), findsWidgets);
  });

  testWidgets('solo-only hides the invite card', (tester) async {
    await tester.pumpApp(TodayCarousel(home: _home(isPaired: false), isSoloOnly: true));
    await tester.pumpAndSettle();

    expect(find.text('CONVITE'), findsNothing);
  });

  testWidgets('a received card and a finished week appear when they exist', (tester) async {
    await tester.pumpApp(
      TodayCarousel(home: _home(unopenedCards: 1, slipsThisWeek: 2), isSoloOnly: false),
    );
    await tester.pumpAndSettle();

    expect(find.text('CARTÃO'), findsWidgets);
    expect(find.text('SUA SEMANA'), findsWidgets);
  });

  testWidgets('shows nothing when there is nothing to offer', (tester) async {
    await tester.pumpApp(
      const TodayCarousel(
        home: TodayHome(
          isPaired: true,
          unopenedCards: 0,
          slipsThisWeek: 0,
          slipsTotal: 0,
          hasPendingInvite: false,
          hasPlus: false,
        ),
        isSoloOnly: false,
      ),
    );

    expect(find.byType(BaseCarousel), findsNothing);
  });
}
