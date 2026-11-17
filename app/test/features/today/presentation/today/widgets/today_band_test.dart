import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/notifications/presentation/off_banner/cubit/notifications_off_cubit.dart';
import 'package:app/features/notifications/presentation/off_banner/widgets/notifications_off_banner.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/today_band.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

TodayHome _home({bool isPaired = true, bool hasPendingInvite = false}) => TodayHome(
  isPaired: isPaired,
  unopenedCards: 0,
  slipsThisWeek: 2,
  slipsTotal: 2,
  hasPendingInvite: hasPendingInvite,
  hasPlus: false,
);

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('a pending invite is the band, even with no connection', (tester) async {
    await tester.pumpApp(
      TodayBand(
        home: _home(isPaired: false, hasPendingInvite: true),
        isOffline: true,
        notificationsOff: const SizedBox.shrink(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('CONVITE ENVIADO'), findsOneWidget);
    expect(find.textContaining('Sem conexão'), findsNothing);
    expect(find.byType(NotificationsOffBanner), findsNothing);
  });

  testWidgets('no connection is the band when nothing waits on an invite', (tester) async {
    await tester.pumpApp(
      TodayBand(home: _home(), isOffline: true, notificationsOff: const SizedBox.shrink()),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Sem conexão'), findsOneWidget);
    expect(find.byType(NotificationsOffBanner), findsNothing);
  });

  testWidgets('with everything else fine the reminders notice takes the band', (tester) async {
    final repository = _MockNotificationsRepository();
    when(repository.currentAccess).thenAnswer((_) async => NotificationAccess.denied);
    when(() => repository.isOffBannerDismissed).thenReturn(false);
    AppInjector.instance.registerFactory<NotificationsOffCubit>(
      () => NotificationsOffCubit(repository: repository),
    );
    addTearDown(() => AppInjector.instance.unregister<NotificationsOffCubit>());

    await tester.pumpApp(TodayBand(home: _home(), isOffline: false));
    await tester.pump();
    await tester.pump();

    expect(find.text('Os lembretes estão desligados. Ligue nas configurações.'), findsOneWidget);
    expect(find.textContaining('Sem conexão'), findsNothing);
  });
}
