import 'package:app/features/repair/presentation/sos/sos_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('the three ways in are offered and nothing is sent from here', (tester) async {
    await tester.pumpApp(const SosPage());
    await tester.pump();

    expect(find.text('Começo suave'), findsOneWidget);
    expect(find.text('Reparar'), findsOneWidget);
    expect(find.text('Preparar o que dizer'), findsOneWidget);
    expect(find.text('Funciona sem internet e fica só com você.'), findsOneWidget);
  });
}
