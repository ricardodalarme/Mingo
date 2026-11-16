import 'package:app/features/authentication/presentation/sign_in/cubit/sign_in_cubit.dart';
import 'package:app/features/authentication/presentation/sign_in/widgets/provider_buttons.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class MockSignInCubit() extends MockCubit<SignInState> implements SignInCubit;

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('always offers Apple and Google and hides the email action outside debug builds', (
    tester,
  ) async {
    final cubit = MockSignInCubit();
    when(() => cubit.state).thenReturn(const SignInState());

    await tester.pumpApp(
      BlocProvider<SignInCubit>.value(value: cubit, child: const ProviderButtons()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Continuar com a Apple'), findsOneWidget);
    expect(find.text('Continuar com o Google'), findsOneWidget);
    expect(find.text('Entrar com e-mail e senha'), findsNothing);
  });
}
