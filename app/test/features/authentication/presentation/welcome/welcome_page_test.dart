import 'package:app/features/authentication/presentation/welcome/welcome_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('the welcome screen offers starting or signing in and no settings', (tester) async {
    await tester.pumpApp(const WelcomePage());
    await tester.pumpAndSettle();

    expect(find.text('Começar'), findsOneWidget);
    expect(find.text('Já tenho conta'), findsOneWidget);
    expect(find.widgetWithIcon(BaseRoundButton, AppIcons.settings), findsNothing);
  });
}
