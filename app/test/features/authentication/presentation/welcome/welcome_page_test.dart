import 'package:app/features/authentication/presentation/welcome/welcome_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('the welcome screen offers settings before sign-in', (tester) async {
    await tester.pumpApp(const WelcomePage());
    await tester.pumpAndSettle();

    final gear = tester.widget<BaseRoundButton>(
      find.widgetWithIcon(BaseRoundButton, AppIcons.settings),
    );

    expect(gear.onPressed, isNotNull);
    expect(gear.semanticLabel, Translations().settingsHome.title);
  });
}
