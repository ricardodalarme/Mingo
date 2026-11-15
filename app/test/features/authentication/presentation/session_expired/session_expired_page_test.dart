import 'package:app/features/authentication/presentation/session_expired/session_expired_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('explains the expiry and opens the sign-in flow', (tester) async {
    var signInRequested = false;

    await tester.pumpApp(SessionExpiredPage(onSignIn: () => signInRequested = true));
    await tester.pump();

    expect(find.textContaining('Sua sessão'), findsOneWidget);
    expect(find.text('Entre de novo para continuar. Seus dados estão seguros.'), findsOneWidget);

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(signInRequested, isTrue);
  });
}
