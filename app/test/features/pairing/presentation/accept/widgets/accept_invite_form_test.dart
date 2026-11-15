import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/features/pairing/presentation/accept/widgets/accept_invite_form.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _FakeInviteCodeStore() implements InviteCodeStore {
  String? code;

  @override
  String? read() => code;

  @override
  Future<void> save(String value) async => code = value;

  @override
  Future<void> clear() async => code = null;
}

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  AcceptInviteCubit build(_FakeInviteCodeStore inviteCodes) => AcceptInviteCubit(
    pairingRepository: _MockPairingRepository(),
    profileRepository: _MockProfileRepository(),
    inviteCodes: inviteCodes,
  );

  testWidgets('the invite hint reads as an example, not a prefilled code', (tester) async {
    final cubit = build(_FakeInviteCodeStore());
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const AcceptInviteForm()));
    await tester.pumpAndSettle();

    expect(tester.widget<BaseTextField>(find.byType(BaseTextField)).hint, 'Ex.: ABCD2345');
    expect(tester.widget<BaseTextField>(find.byType(BaseTextField)).text, isEmpty);
  });

  testWidgets('an invite link pre-fills the code from the kept invite', (tester) async {
    final cubit = build(_FakeInviteCodeStore()..code = 'abcd2345')..start();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const AcceptInviteForm()));
    await tester.pumpAndSettle();

    expect(tester.widget<BaseTextField>(find.byType(BaseTextField)).text, 'ABCD2345');
  });

  testWidgets('the route code pre-fills the form', (tester) async {
    final cubit = build(_FakeInviteCodeStore())..start(code: 'abcd2345');
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const AcceptInviteForm()));
    await tester.pumpAndSettle();

    expect(tester.widget<BaseTextField>(find.byType(BaseTextField)).text, 'ABCD2345');
  });
}
