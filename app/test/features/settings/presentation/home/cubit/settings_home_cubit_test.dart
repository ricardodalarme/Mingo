import 'package:app/features/account/data/repositories/account_repository.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/plus/data/models/plus_state.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/settings/presentation/home/cubit/settings_home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockPlusRepository() extends Mock implements PlusRepository;

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

class _MockAccountRepository() extends Mock implements AccountRepository;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late PairingRepository pairing;
  late PlusRepository plus;
  late NotificationsRepository notifications;
  late AccountRepository account;
  late AuthenticationRepository authentication;

  setUp(() {
    pairing = _MockPairingRepository();
    plus = _MockPlusRepository();
    notifications = _MockNotificationsRepository();
    account = _MockAccountRepository();
    authentication = _MockAuthenticationRepository();
    when(() => authentication.isAuthenticated).thenReturn(true);
    when(() => account.getDeletion()).thenAnswer((_) async => null);
  });

  SettingsHomeCubit build() => SettingsHomeCubit(
    pairingRepository: pairing,
    plusRepository: plus,
    notificationsRepository: notifications,
    accountRepository: account,
    authenticationRepository: authentication,
  );

  test('each section shows its current state', () async {
    when(() => pairing.getPartner()).thenAnswer(
      (_) async => const Profile(id: 'p', avatarKind: AvatarKind.initials, displayName: 'Rui'),
    );
    when(() => plus.getPlus()).thenAnswer((_) async => const PlusState(hasPlus: true));
    when(() => notifications.getPreferences())
        .thenAnswer((_) async => const NotificationPreferences(isEnabled: false));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.isAuthenticated, isTrue);
    expect(cubit.state.partnerName, 'Rui');
    expect(cubit.state.hasPartner, isTrue);
    expect(cubit.state.hasPlus, isTrue);
    expect(cubit.state.notificationsOn, isFalse);
  });

  test('without a partner the relationship rows stay hidden', () async {
    when(() => pairing.getPartner()).thenAnswer((_) async => null);
    when(() => plus.getPlus()).thenAnswer((_) async => const PlusState(hasPlus: false));
    when(() => notifications.getPreferences())
        .thenAnswer((_) async => const NotificationPreferences());
    final cubit = build();

    await cubit.load();

    expect(cubit.state.hasPartner, isFalse);
    expect(cubit.state.hasRelationship, isFalse);
  });

  test('signed out it reads nothing and keeps the local rows only', () async {
    when(() => authentication.isAuthenticated).thenReturn(false);
    final cubit = build();

    await cubit.load();

    expect(cubit.state.isLoaded, isTrue);
    expect(cubit.state.isAuthenticated, isFalse);
    expect(cubit.state.hasPartner, isNull);
    expect(cubit.state.hasRelationship, isFalse);
    verifyNever(() => pairing.getPartner());
    verifyNever(() => plus.getPlus());
    verifyNever(() => notifications.getPreferences());
    verifyNever(() => account.getDeletion());
  });

  test('a section that cannot be read shows no status and does not block the rest', () async {
    when(() => pairing.getPartner()).thenThrow(Exception('offline'));
    when(() => plus.getPlus()).thenThrow(Exception('offline'));
    when(() => notifications.getPreferences())
        .thenAnswer((_) async => const NotificationPreferences());
    final cubit = build();

    await cubit.load();

    expect(cubit.state.isLoaded, isTrue);
    expect(cubit.state.hasPartner, isNull);
    expect(cubit.state.hasRelationship, isFalse);
    expect(cubit.state.hasPlus, isNull);
    expect(cubit.state.notificationsOn, isTrue);
  });
}
