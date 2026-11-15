import 'package:app/features/share/presentation/widgets/counter_share_card.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('shows the days together, the duration and the start date', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 11, 15, 12)), () async {
      await tester.pumpApp(Center(child: CounterShareCard(since: DateTime(2024, 3, 14))));

      expect(find.text('NOSSO TEMPO'), findsOneWidget);
      expect(find.text('976'), findsOneWidget);
      expect(find.text('dias juntos'), findsOneWidget);
      expect(find.text('2 anos, 8 meses e 1 dia'), findsOneWidget);
      expect(find.text('Desde 14 de março de 2024'), findsOneWidget);
      expect(find.text('Mingo'), findsOneWidget);
    });
  });

  testWidgets('a couple still on the first day counts one day', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 11, 15, 12)), () async {
      await tester.pumpApp(Center(child: CounterShareCard(since: DateTime(2026, 11, 15))));

      expect(find.text('0'), findsOneWidget);
      expect(find.text('dias juntos'), findsOneWidget);
    });
  });
}
