import 'package:app/features/share/data/models/moon_phase.dart';
import 'package:app/features/share/presentation/widgets/moon_phase_view.dart';
import 'package:app/features/share/presentation/widgets/moon_share_card.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('shows the moon of the day, its phase and the date', (tester) async {
    await tester.pumpApp(Center(child: MoonShareCard(date: DateTime.utc(2024, 4, 23, 23, 49))));

    expect(find.text('A LUA DO NOSSO DIA'), findsOneWidget);
    expect(find.text('Lua cheia'), findsOneWidget);
    expect(find.text('Foi assim que o céu estava quando tudo começou.'), findsOneWidget);
    expect(find.text('23 de abril de 2024'), findsOneWidget);
    expect(find.text('Mingo'), findsOneWidget);

    final moon = tester.widget<MoonPhaseView>(find.byType(MoonPhaseView));
    expect(moon.phase, MoonPhase.fullMoon);
  });

  testWidgets('a new moon still reads as a moon and a date', (tester) async {
    await tester.pumpApp(Center(child: MoonShareCard(date: DateTime.utc(2024, 4, 8, 18))));

    expect(find.text('Lua nova'), findsOneWidget);
    expect(find.text('8 de abril de 2024'), findsOneWidget);
    expect(find.byType(MoonPhaseView), findsOneWidget);
  });
}
