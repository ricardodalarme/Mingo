import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/pairing/data/models/active_invite.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/features/pairing/presentation/connect/connect_code_sheet.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

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
    LocaleSettings.setLocaleSync(AppLocale.pt);
    pairing = _MockPairingRepository();
    profile = _MockProfileRepository();
    inviteCodes = _FakeInviteCodeStore();
    when(pairing.getActiveInvite).thenAnswer((_) async => null);
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

  Future<void> pumpSheet(
    WidgetTester tester,
    AcceptInviteCubit cubit, {
    VoidCallback? onConnected,
  }) async {
    addTearDown(cubit.close);
    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: ConnectCodeContent(onConnected: onConnected ?? () {}),
      ),
    );
    await tester.pump();
  }

  Future<void> accept(WidgetTester tester, String code) async {
    await tester.enterText(find.byType(BaseTextField), code);
    await tester.tap(find.text('Aceitar'));
    await tester.pump();
    await tester.pump();
  }

  testWidgets('entering a code connects and clears the kept invite', (tester) async {
    inviteCodes.code = 'ABCD2345';
    when(() => pairing.acceptInvite('ABCD2345')).thenAnswer((_) async => true);
    var connected = false;
    await pumpSheet(tester, build(), onConnected: () => connected = true);

    await accept(tester, 'abcd2345');

    expect(connected, isTrue);
    expect(inviteCodes.code, isNull);
    expect(find.text('Vocês estão conectados'), findsOneWidget);
  });

  testWidgets('an unusable code shows the error and keeps the code field open', (tester) async {
    when(() => pairing.acceptInvite(any())).thenAnswer((_) async => false);
    var connected = false;
    await pumpSheet(tester, build(), onConnected: () => connected = true);

    await accept(tester, 'abcd2345');

    expect(
      find.text('Confira o código ou peça um novo convite para quem convidou.'),
      findsOneWidget,
    );
    expect(find.byType(BaseTextField), findsOneWidget);
    expect(connected, isFalse);
  });

  testWidgets("the person's own code says they cannot connect to themselves", (tester) async {
    when(pairing.getActiveInvite).thenAnswer(
      (_) async => ActiveInvite(id: 'i1', code: 'ABCD2345', expiresAt: DateTime.utc(2026, 12, 1)),
    );
    await pumpSheet(tester, build());

    await accept(tester, 'abcd2345');

    expect(find.textContaining('seu próprio código'), findsOneWidget);
    verifyNever(() => pairing.acceptInvite(any()));
  });

  testWidgets('a pasted invite link is reduced to its code', (tester) async {
    await pumpSheet(tester, build());

    await tester.enterText(find.byType(BaseTextField), 'https://mingo.app/invite/abcd2345');
    await tester.pump();

    expect(tester.widget<BaseTextField>(find.byType(BaseTextField)).text, 'ABCD2345');
  });
}
