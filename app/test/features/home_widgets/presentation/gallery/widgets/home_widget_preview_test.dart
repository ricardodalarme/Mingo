import 'package:app/features/home_widgets/data/models/home_widget_card_state.dart';
import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_preview.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  final today = DateTime(2026, 11, 11, 12);

  Future<void> pump(
    WidgetTester tester,
    HomeWidgetKind kind,
    HomeWidgetPayload payload, {
    HomeWidgetSize size = HomeWidgetSize.small,
  }) async {
    await withClock(Clock.fixed(today), () async {
      await tester.pumpApp(
        BaseView(
          body: SizedBox(
            width: size == HomeWidgetSize.small ? 169 : 358,
            child: HomeWidgetPreview(variant: (kind: kind, size: size), payload: payload),
          ),
        ),
      );
    });
  }

  HomeWidgetPayload paired({
    String? partnerNote,
    MoodKind? mood,
    HomeWidgetCardState cardState = HomeWidgetCardState.none,
  }) => HomeWidgetPayload(
    isSignedIn: true,
    isPaired: true,
    updatedAt: '',
    ownName: 'Alex',
    partnerName: 'Sam',
    togetherSince: '2024-02-14',
    partnerNote: partnerNote,
    partnerNoteAt: '2026-11-11T09:40:00',
    partnerMood: mood,
    partnerMoodAt: '2026-11-11T10:00:00',
    cardState: cardState,
    cardSendDay: 0,
    cardSendHour: 18,
    nextDateTitle: 'Aniversário',
    nextDateOn: '2026-11-23',
    ritualTitle: 'Boa noite de nós',
    ritualWeekday: 3,
    ritualTime: '22:00',
    dailyIdeaTitle: 'Deixe um bilhete na mochila',
    slipsThisWeek: 3,
    slipDays: const ['2026-11-09', '2026-11-11'],
    ownZone: 'America/Sao_Paulo',
    partnerZone: 'Europe/Lisbon',
    reunionOn: '2026-12-23',
  );

  testWidgets('every widget renders for a couple without overflowing', (tester) async {
    for (final group in HomeWidgetGalleryGroup.values) {
      for (final variant in group.variants) {
        await pump(
          tester,
          variant.kind,
          paired(mood: MoodKind.loving, partnerNote: 'Oi'),
          size: variant.size,
        );

        expect(tester.takeException(), isNull, reason: variant.labelKey);
      }
    }
  });

  testWidgets('the counter shows the days, the unit and both initials', (tester) async {
    await pump(tester, HomeWidgetKind.counter, paired());

    expect(find.text('1001'), findsOneWidget);
    expect(find.text('dias'), findsOneWidget);
    expect(find.text('A'), findsOneWidget);
    expect(find.text('S'), findsOneWidget);
  });

  testWidgets('the counter asks for the date when there is none', (tester) async {
    await pump(
      tester,
      HomeWidgetKind.counter,
      const HomeWidgetPayload(isSignedIn: true, isPaired: false, updatedAt: ''),
    );

    expect(find.text('Defina a data de vocês'), findsOneWidget);
  });

  testWidgets('the medium counter spells out years, months and days', (tester) async {
    await pump(tester, HomeWidgetKind.counter, paired(), size: HomeWidgetSize.medium);

    expect(find.text('2 anos, 8 meses e 28 dias'), findsOneWidget);
    expect(find.text('Hoje'), findsOneWidget);
  });

  testWidgets('the mood widget names the shared mood and says how long ago', (tester) async {
    await pump(tester, HomeWidgetKind.partnerMood, paired(mood: MoodKind.loving));

    expect(find.text('Carinhoso(a)'), findsOneWidget);
    expect(find.text('há 2 horas'), findsOneWidget);
    expect(find.text('SAM AGORA'), findsOneWidget);
  });

  testWidgets('the mood widget says so when nothing is shared', (tester) async {
    await pump(tester, HomeWidgetKind.partnerMood, paired());

    expect(find.text('O humor aparece quando seu par compartilhar.'), findsOneWidget);
  });

  testWidgets('the note shows the words and who sent them', (tester) async {
    await pump(tester, HomeWidgetKind.partnerNote, paired(partnerNote: 'Jantar hoje?'));

    expect(find.text('Jantar hoje?'), findsOneWidget);
    expect(find.text('de Sam · 09:40'), findsOneWidget);
  });

  testWidgets('without a note the widget says there is none', (tester) async {
    await pump(tester, HomeWidgetKind.partnerNote, paired(), size: HomeWidgetSize.medium);

    expect(find.text('Nenhum recado por aqui'), findsOneWidget);
  });

  testWidgets('a widget about the partner invites one when there is no couple', (tester) async {
    await pump(
      tester,
      HomeWidgetKind.partnerMood,
      const HomeWidgetPayload(isSignedIn: true, isPaired: false, updatedAt: ''),
    );

    expect(find.text('Convide seu par para ver aqui'), findsOneWidget);
    expect(find.text('Convidar'), findsOneWidget);
  });

  testWidgets('the ritual says when it comes next', (tester) async {
    await pump(tester, HomeWidgetKind.ritual, paired());

    expect(find.text('Boa noite de nós'), findsOneWidget);
    expect(find.text('hoje, 22:00'), findsOneWidget);
  });

  testWidgets('the Sunday card states where the card is', (tester) async {
    await pump(tester, HomeWidgetKind.card, paired());
    expect(find.text('sai dom, 18:00'), findsOneWidget);
    expect(find.text('3 coisas boas'), findsOneWidget);

    await pump(tester, HomeWidgetKind.card, paired(cardState: HomeWidgetCardState.ready));
    expect(find.text('Chegou um cartão'), findsOneWidget);
  });

  testWidgets('the ticket shows the next date and its title', (tester) async {
    await pump(tester, HomeWidgetKind.card, paired(), size: HomeWidgetSize.medium);

    expect(find.text('23'), findsOneWidget);
    expect(find.text('Aniversário'), findsOneWidget);
    expect(find.text('PRÓXIMO ENCONTRO'), findsOneWidget);
  });

  testWidgets('the next date counts the days down', (tester) async {
    await pump(tester, HomeWidgetKind.nextDate, paired());

    expect(find.text('12'), findsOneWidget);
    expect(find.text('Aniversário'), findsOneWidget);
  });

  testWidgets('the week counts slips and marks their weekdays', (tester) async {
    await pump(tester, HomeWidgetKind.week, paired(), size: HomeWidgetSize.medium);

    expect(find.text('3 slips'), findsOneWidget);
    expect(find.text('seg'), findsOneWidget);
    expect(find.text('dom'), findsOneWidget);
  });

  testWidgets('a busy day does not overflow the week bars', (tester) async {
    const busy = HomeWidgetPayload(
      isSignedIn: true,
      isPaired: false,
      updatedAt: '',
      slipsThisWeek: 5,
      slipDays: ['2026-11-11', '2026-11-11', '2026-11-11', '2026-11-11', '2026-11-11'],
    );
    await pump(tester, HomeWidgetKind.week, busy, size: HomeWidgetSize.medium);

    expect(tester.takeException(), isNull);
    expect(find.text('5 slips'), findsOneWidget);
  });

  testWidgets('the idea widget shows the idea of the day', (tester) async {
    await pump(tester, HomeWidgetKind.idea, paired(), size: HomeWidgetSize.medium);

    expect(find.text('Deixe um bilhete na mochila'), findsOneWidget);
  });

  testWidgets('the distance widget counts the days until the couple meets', (tester) async {
    await pump(tester, HomeWidgetKind.distance, paired(), size: HomeWidgetSize.medium);

    expect(find.text('42'), findsOneWidget);
    expect(find.text('dias até se verem'), findsOneWidget);
    expect(find.text('Sao Paulo · você'), findsOneWidget);
  });
}
