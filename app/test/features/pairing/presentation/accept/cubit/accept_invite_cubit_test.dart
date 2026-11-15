import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mocktail/mocktail.dart';

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
  late PairingRepository pairing;
  late ProfileRepository profile;
  late _FakeInviteCodeStore inviteCodes;

  setUp(() {
    pairing = _MockPairingRepository();
    profile = _MockProfileRepository();
    inviteCodes = _FakeInviteCodeStore();
    when(() => profile.getMyProfile()).thenAnswer(
      (_) async => const Profile(id: 'me', avatarKind: AvatarKind.initials, displayName: 'Ana'),
    );
    when(() => pairing.getPartner()).thenAnswer(
      (_) async => const Profile(id: 'p', avatarKind: AvatarKind.initials, displayName: 'Rui'),
    );
  });

  AcceptInviteCubit build() => AcceptInviteCubit(
    pairingRepository: pairing,
    profileRepository: profile,
    inviteCodes: inviteCodes,
  );

  test('start pre-fills the code kept from an invite link', () {
    inviteCodes.code = 'abcd2345';
    final cubit = build()..start();

    expect(cubit.state.code.value, 'ABCD2345');
  });

  test('start pre-fills the code carried by the route', () {
    inviteCodes.code = 'ZZZZ9999';
    final cubit = build()..start(code: 'abcd2345');

    expect(cubit.state.code.value, 'ABCD2345');
  });

  test('start keeps the form empty when no invite was opened', () {
    final cubit = build()..start();

    expect(cubit.state.code.value, isEmpty);
  });

  test('the code is cleaned up, upper-cased and capped at the issued length', () {
    final cubit = build()..onCodeChanged(' abcd 2345 extra ');

    expect(cubit.state.code.value, 'ABCD2345');
    expect(cubit.state.code.isValid, isTrue);
  });

  test('a short code cannot be sent', () async {
    final cubit = build()..onCodeChanged('abc');
    await cubit.accept();

    expect(cubit.state.code.error, MinLengthValidationError.tooShort);
    verifyNever(() => pairing.acceptInvite(any()));
  });

  test('a valid code connects, loads both names and clears the kept code', () async {
    inviteCodes.code = 'ABCD2345';
    when(() => pairing.acceptInvite('ABCD2345')).thenAnswer((_) async => true);
    final cubit = build()..onCodeChanged('abcd2345');
    await cubit.accept();

    expect(cubit.state.acceptAction, const Success<AcceptOutcome>(AcceptOutcome.connected));
    expect(cubit.state.partnerName, 'Rui');
    expect(cubit.state.selfName, 'Ana');
    expect(inviteCodes.code, isNull);
  });

  test('an unusable code clears the kept code and can be retried', () async {
    inviteCodes.code = 'ABCD2345';
    when(() => pairing.acceptInvite(any())).thenAnswer((_) async => false);
    final cubit = build()..onCodeChanged('abcd2345');
    await cubit.accept();

    expect(cubit.state.acceptAction, const Success<AcceptOutcome>(AcceptOutcome.unusable));
    expect(inviteCodes.code, isNull);

    cubit.tryAgain();
    expect(cubit.state.acceptAction, const Initial());
    expect(cubit.state.code.value, 'ABCD2345');
  });

  test('a server error keeps the kept code for a retry', () async {
    inviteCodes.code = 'ABCD2345';
    when(() => pairing.acceptInvite(any()))
        .thenAnswer((_) async => throw const LocalizedException(l10nKey: 'ALREADY_PAIRED'));
    final cubit = build()..onCodeChanged('abcd2345');
    await cubit.accept();

    expect(cubit.state.acceptAction, const Initial());
    expect(inviteCodes.code, 'ABCD2345');
  });
}
