import 'package:app/features/account/data/repositories/account_repository.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/plus/data/models/plus_state.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/settings/data/models/settings.dart';
import 'package:app/features/settings/data/repositories/settings_repository.dart';
import 'package:app/features/settings/presentation/home/cubit/settings_home_cubit.dart';
import 'package:app/features/settings/presentation/home/settings_home_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockPlusRepository() extends Mock implements PlusRepository;

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

class _MockAccountRepository() extends Mock implements AccountRepository;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

class _MockSettingsRepository() extends Mock implements SettingsRepository;

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUpAll(() => registerFallbackValue(true));

  final l10n = Translations();

  late PairingRepository pairing;
  late PlusRepository plus;
  late NotificationsRepository notifications;
  late AccountRepository account;
  late AuthenticationRepository authentication;
  late SettingsRepository settingsRepository;

  setUp(() {
    pairing = _MockPairingRepository();
    plus = _MockPlusRepository();
    notifications = _MockNotificationsRepository();
    account = _MockAccountRepository();
    authentication = _MockAuthenticationRepository();
    settingsRepository = _MockSettingsRepository();
    when(settingsRepository.get).thenReturn(const Settings.empty());
    when(() => account.getDeletion()).thenAnswer((_) async => null);
    when(() => plus.getPlus()).thenAnswer((_) async => const PlusState(hasPlus: false));
    when(() => notifications.getPreferences())
        .thenAnswer((_) async => const NotificationPreferences());
    AppInjector.instance.registerFactory<SettingsRepository>(() => settingsRepository);
    addTearDown(() => AppInjector.instance.unregister<SettingsRepository>());
  });

  SettingsHomeCubit buildHome() => SettingsHomeCubit(
    pairingRepository: pairing,
    plusRepository: plus,
    notificationsRepository: notifications,
    accountRepository: account,
    authenticationRepository: authentication,
  );

  Future<void> pumpSettings(WidgetTester tester, SettingsHomeCubit home) async {
    addTearDown(home.close);
    await tester.pumpApp(BlocProvider.value(value: home, child: const SettingsHomePage()));
    await tester.pumpAndSettle();
  }

  testWidgets('signed out it shows the local rows and no session or partner rows', (tester) async {
    when(() => authentication.isAuthenticated).thenReturn(false);
    final home = buildHome();
    await home.load();

    await pumpSettings(tester, home);

    expect(find.text(l10n.settingsHome.theme), findsOneWidget);
    expect(find.text(l10n.settingsHome.language), findsOneWidget);
    expect(find.text(l10n.settingsHome.help), findsOneWidget);

    expect(find.text(l10n.settingsHome.accountSection), findsNothing);
    expect(find.text(l10n.settingsHome.profile), findsNothing);
    expect(find.text(l10n.settingsHome.plan), findsNothing);
    expect(find.text(l10n.settingsHome.notifications), findsNothing);
    expect(find.text(l10n.settingsHome.devices), findsNothing);
    expect(find.text(l10n.settingsHome.weeklyCard), findsNothing);
    expect(find.text(l10n.widgets.settingsTitle), findsNothing);
    expect(find.text(l10n.settingsHome.signOut), findsNothing);
    expect(find.text(l10n.settingsHome.deleteAccount), findsNothing);
    expect(find.text(l10n.settingsHome.relationship), findsNothing);
    expect(find.text(l10n.settingsHome.spice), findsNothing);
    expect(find.text(l10n.settingsHome.privacy), findsNothing);
  });

  testWidgets('signed in without a partner it keeps the session rows and hides the couple ones', (
    tester,
  ) async {
    when(() => authentication.isAuthenticated).thenReturn(true);
    when(() => pairing.getPartner()).thenAnswer((_) async => null);
    final home = buildHome();
    await home.load();

    await pumpSettings(tester, home);

    expect(find.text(l10n.settingsHome.accountSection), findsOneWidget);
    expect(find.text(l10n.settingsHome.profile), findsOneWidget);
    expect(find.text(l10n.settingsHome.plan), findsOneWidget);
    expect(find.text(l10n.settingsHome.notifications), findsOneWidget);
    expect(find.text(l10n.settingsHome.devices), findsOneWidget);
    expect(find.text(l10n.settingsHome.weeklyCard), findsOneWidget);
    expect(find.text(l10n.settingsHome.signOut), findsOneWidget);
    expect(find.text(l10n.settingsHome.deleteAccount), findsOneWidget);

    expect(find.text(l10n.settingsHome.relationship), findsNothing);
    expect(find.text(l10n.settingsHome.spice), findsNothing);
    expect(find.text(l10n.settingsHome.privacy), findsNothing);
  });

  testWidgets('signed in with a partner it shows the couple rows', (tester) async {
    when(() => authentication.isAuthenticated).thenReturn(true);
    when(() => pairing.getPartner()).thenAnswer(
      (_) async => const Profile(id: 'p', avatarKind: AvatarKind.initials, displayName: 'Rui'),
    );
    final home = buildHome();
    await home.load();

    await pumpSettings(tester, home);

    expect(find.text(l10n.settingsHome.relationship), findsOneWidget);
    expect(find.text(l10n.settingsHome.connectedWith(name: 'Rui')), findsOneWidget);
    expect(find.text(l10n.settingsHome.spice), findsOneWidget);
    expect(find.text(l10n.settingsHome.privacy), findsOneWidget);
  });
}
