import 'package:app/features/privacy/data/models/consent.dart';
import 'package:app/features/privacy/data/repositories/privacy_repository.dart';
import 'package:app/features/privacy/presentation/consents/consents_page.dart';
import 'package:app/features/privacy/presentation/consents/cubit/consents_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockPrivacyRepository() extends Mock implements PrivacyRepository;

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(ConsentKind.marketing);
  });

  testWidgets('required consents are fixed and optional ones still toggle', (tester) async {
    final repository = _MockPrivacyRepository();
    when(repository.getConsents)
        .thenAnswer((_) async => {for (final kind in ConsentKind.values) kind: kind.isRequired});
    when(() => repository.setConsent(any(), granted: any(named: 'granted'))).thenAnswer((_) async {
      return;
    });
    final cubit = ConsentsCubit(repository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const ConsentsPage()));
    await tester.pumpAndSettle();

    expect(find.text('Obrigatório'), findsOneWidget);
    expect(find.byType(BaseSwitch), findsNWidgets(ConsentKind.values.length - 1));
    expect(find.text('Aceitar os Termos é obrigatório para usar o app.'), findsOneWidget);

    await tester.tap(find.text('Marketing'));
    await tester.pumpAndSettle();

    verify(() => repository.setConsent(ConsentKind.marketing, granted: true)).called(1);
    verifyNever(() => repository.setConsent(ConsentKind.terms, granted: any(named: 'granted')));
  });
}
