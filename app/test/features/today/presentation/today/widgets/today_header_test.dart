import 'package:app/features/notifications/data/repositories/inbox_repository.dart';
import 'package:app/features/notifications/presentation/bell/cubit/inbox_badge_cubit.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/today_header.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockInboxRepository() extends Mock implements InboxRepository;

Future<void> _pump(WidgetTester tester, Widget header, {int unread = 0}) async {
  final inbox = _MockInboxRepository();
  when(inbox.watchUnreadCount).thenAnswer((_) => Stream.value(unread));
  final badge = InboxBadgeCubit(inboxRepository: inbox)..start();
  addTearDown(badge.close);

  await tester.pumpApp(BlocProvider.value(value: badge, child: header));
}

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  const home = TodayHome(
    isPaired: true,
    unopenedCards: 0,
    slipsThisWeek: 2,
    slipsTotal: 2,
    hasPendingInvite: false,
    hasPlus: false,
    partnerName: 'Rui',
  );

  testWidgets('the greeting uses the title scale with a time-of-day glyph', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      final now = clock.now();
      final l10n = Translations();
      final greeting = switch (now.hour) {
        < 12 => l10n.today.greetingMorning(name: 'Ana'),
        < 18 => l10n.today.greetingAfternoon(name: 'Ana'),
        _ => l10n.today.greetingEvening(name: 'Ana'),
      };
      final timeIcon = now.hour >= 18 || now.hour < 6 ? AppIcons.moon : AppIcons.sun;

      await _pump(tester, const TodayHeader(home: home, selfName: 'Ana'));

      final greetingText = tester.widget<Text>(find.text(greeting));
      expect(greetingText.style?.fontSize, AppTypography.system.titleLg.fontSize);
      expect(greetingText.style?.fontWeight, AppTypography.system.titleLg.fontWeight);
      expect(find.byIcon(timeIcon), findsOneWidget);
    });
  });

  testWidgets('the date uses the small body scale', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      final now = clock.now();
      final l10n = Translations();
      final dateLine = l10n.today.dateLine(
        weekday: l10n.today.weekdays[now.weekday - 1],
        day: now.day,
        month: l10n.today.months[now.month - 1],
      );

      await _pump(tester, const TodayHeader(home: home, selfName: 'Ana'));

      final date = tester.widget<Text>(find.text(dateLine));
      expect(date.style?.fontSize, AppTypography.system.bodySm.fontSize);
    });
  });

  testWidgets('the header no longer shows how long the couple has been together', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      await _pump(
        tester,
        TodayHeader(
          home: TodayHome(
            isPaired: true,
            unopenedCards: 0,
            slipsThisWeek: 2,
            slipsTotal: 2,
            hasPendingInvite: false,
            hasPlus: false,
            partnerName: 'Rui',
            togetherSince: DateTime(2024, 3, 10),
          ),
          selfName: 'Ana',
        ),
      );

      expect(find.byIcon(AppIcons.heart_filled), findsNothing);
    });
  });

  testWidgets('on your own the header offers settings', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      await _pump(
        tester,
        const TodayHeader(
          home: TodayHome(
            isPaired: false,
            unopenedCards: 0,
            slipsThisWeek: 2,
            slipsTotal: 2,
            hasPendingInvite: false,
            hasPlus: false,
          ),
          selfName: 'Ana',
        ),
      );

      final gear = tester.widget<BaseRoundButton>(
        find.widgetWithIcon(BaseRoundButton, AppIcons.settings),
      );

      expect(gear.onPressed, isNotNull);
      expect(gear.semanticLabel, Translations().settingsHome.title);
    });
  });

  testWidgets('with a partner the header still offers settings', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      await _pump(tester, const TodayHeader(home: home, selfName: 'Ana'));

      expect(find.byIcon(AppIcons.settings), findsOneWidget);
    });
  });

  testWidgets('the bell shows a dot only while something is unread', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      await _pump(tester, const TodayHeader(home: home, selfName: 'Ana'), unread: 2);
      await tester.pump();

      expect(
        tester
            .widget<BaseRoundButton>(find.widgetWithIcon(BaseRoundButton, AppIcons.bell))
            .hasBadge,
        isTrue,
      );
    });
  });

  testWidgets('the bell shows no dot when everything is read', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      await _pump(tester, const TodayHeader(home: home, selfName: 'Ana'));
      await tester.pump();

      expect(
        tester
            .widget<BaseRoundButton>(find.widgetWithIcon(BaseRoundButton, AppIcons.bell))
            .hasBadge,
        isFalse,
      );
    });
  });

  testWidgets('on your own the header offers settings', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      await tester.pumpApp(
        const TodayHeader(
          home: TodayHome(
            isPaired: false,
            unopenedCards: 0,
            slipsThisWeek: 2,
            slipsTotal: 2,
            hasPendingInvite: false,
            hasPlus: false,
          ),
          selfName: 'Ana',
        ),
      );

      final gear = tester.widget<BaseRoundButton>(
        find.widgetWithIcon(BaseRoundButton, AppIcons.settings),
      );

      expect(gear.onPressed, isNotNull);
      expect(gear.semanticLabel, Translations().settingsHome.title);
    });
  });

  testWidgets('with a partner the settings gear is not repeated', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      await tester.pumpApp(const TodayHeader(home: home, selfName: 'Ana'));

      expect(find.byIcon(AppIcons.settings), findsNothing);
    });
  });
}
