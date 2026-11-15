import 'package:app/features/settings/presentation/theme/theme_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('the theme page offers the three app colours', (tester) async {
    final l10n = Translations().profileSetup;

    await tester.pumpApp(const SettingsThemePage());
    await tester.pumpAndSettle();

    final rose = tester.widget<BaseChoiceChip>(find.widgetWithText(BaseChoiceChip, l10n.themeRose));

    expect(rose.isSelected, isTrue);
    expect(find.text(l10n.themeBlue), findsOneWidget);
    expect(find.text(l10n.themeNeutral), findsOneWidget);
  });
}
