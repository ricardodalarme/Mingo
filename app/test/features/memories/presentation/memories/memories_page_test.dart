import 'package:app/features/memories/presentation/memories/memories_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('the menu lists the five things the couple keeps', (tester) async {
    await tester.pumpApp(const MemoriesPage());
    await tester.pump();

    expect(find.text('Linha do tempo'), findsOneWidget);
    expect(find.text('Potinho'), findsOneWidget);
    expect(find.text('Nossa história'), findsOneWidget);
    expect(find.text('Datas e números'), findsOneWidget);
    expect(find.text('Diário'), findsOneWidget);
  });
}
