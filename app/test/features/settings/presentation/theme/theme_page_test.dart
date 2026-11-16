import 'package:app/features/settings/presentation/theme/theme_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('the theme page offers the three app colours', (tester) async {
    final l10n = Translations().intro.theme;

    await tester.pumpApp(const SettingsThemePage());
    await tester.pumpAndSettle();

    final rose = tester.widget<BaseOptionTile>(find.widgetWithText(BaseOptionTile, l10n.rose));

    expect(rose.isSelected, isTrue);
    expect(find.text(l10n.blue), findsOneWidget);
    expect(find.text(l10n.neutral), findsOneWidget);
  });
}
