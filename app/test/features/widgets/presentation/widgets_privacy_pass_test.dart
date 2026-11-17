import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/card_encounter/widgets/card_encounter_preview_section.dart';
import 'package:app/features/widgets/presentation/couple_counter/widgets/couple_counter_preview_cards.dart';
import 'package:app/features/widgets/presentation/lock_screen/widgets/lock_screen_preview_section.dart';
import 'package:app/features/widgets/presentation/mood_longing/widgets/mood_longing_preview_section.dart';
import 'package:app/features/widgets/presentation/own_medium/widgets/own_medium_cards.dart';
import 'package:app/features/widgets/presentation/own_small/widgets/own_small_grid.dart';
import 'package:app/features/widgets/presentation/partner_note/widgets/partner_note_preview_section.dart';
import 'package:app/features/widgets/presentation/shared/widget_family_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
  });

  final basePayload = WidgetPayload.fake().copyWith(
    partnerName: 'Marina',
    ownName: 'Luanna',
    partnerNote: 'Boa sorte na reunião!',
    partnerMood: 'loving',
    nextDateTitle: 'Aniversário',
    ritualTitle: 'Caminhada de domingo',
    dailyIdeaTitle: 'Deixe um bilhete na marmita dele',
  );

  Future<void> pumpPreviews(
    WidgetTester tester,
    List<WidgetFamily> families,
    WidgetPayload payload,
  ) {
    return tester.pumpApp(
      BaseView(
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (final family in families)
                SizedBox(
                  width: 340,
                  child: WidgetFamilyPreview(family: family, payload: payload),
                ),
            ],
          ),
        ),
      ),
    );
  }

  group('family previews', () {
    testWidgets('names appear in the counter, mood and note only when allowed', (tester) async {
      await pumpPreviews(tester, [WidgetFamily.counter, WidgetFamily.partnerNote], basePayload);

      expect(find.textContaining('M'), findsWidgets);
      expect(find.text('Boa sorte na reunião!'), findsOneWidget);
    });

    testWidgets('turning names off hides both initials and the note author', (tester) async {
      final payload = basePayload.copyWith(showNames: false).sanitized();
      await pumpPreviews(tester, [WidgetFamily.counter, WidgetFamily.partnerNote], payload);

      expect(find.text('M'), findsNothing);
      expect(find.text('L'), findsNothing);
      expect(find.textContaining('de Marina'), findsNothing);
    });

    testWidgets('the note text is hidden when partner notes are off', (tester) async {
      final payload = basePayload.copyWith(allowPartnerNotes: false).sanitized();
      await pumpPreviews(tester, [WidgetFamily.partnerNote], payload);

      expect(find.text('Boa sorte na reunião!'), findsNothing);
      expect(find.text('Recados estão desligados'), findsOneWidget);
    });

    testWidgets('a mood only shows when the partner shared one', (tester) async {
      await pumpPreviews(tester, [WidgetFamily.partnerMood], basePayload);
      expect(find.text('Carinhoso(a)'), findsOneWidget);

      final hidden = basePayload.copyWith(partnerMood: 'unknown').sanitized();
      await pumpPreviews(tester, [WidgetFamily.partnerMood], hidden);
      expect(find.text('O humor aparece quando seu par compartilhar.'), findsOneWidget);
    });

    testWidgets('the mood never shows without a partner', (tester) async {
      final payload = basePayload.copyWith(isPaired: false).sanitized();
      await pumpPreviews(tester, [WidgetFamily.partnerMood], payload);

      expect(find.textContaining('Marina'), findsNothing);
      expect(find.text('Convide para ver aqui'), findsOneWidget);
    });

    testWidgets('the distance widget asks for the partner timezone when it is missing', (
      tester,
    ) async {
      final payload = basePayload.copyWith(partnerZone: '').sanitized();
      await pumpPreviews(tester, [WidgetFamily.distance], payload);

      expect(find.text('Fuso do seu par ainda não definido'), findsOneWidget);
    });
  });

  group('widget screens', () {
    testWidgets('lock screen never shows a partner name or personal note', (tester) async {
      final payload = basePayload.copyWith(onLockScreen: true);
      await tester.pumpApp(
        BaseView(
          body: SingleChildScrollView(child: LockScreenPreviewSection(payload: payload)),
        ),
      );

      expect(find.textContaining('Marina'), findsNothing);
      expect(find.textContaining('Boa sorte na reunião!'), findsNothing);
      expect(find.text('Momento calmo'), findsWidgets);
    });

    testWidgets('every couple screen renders the no-partner invite state when unpaired', (
      tester,
    ) async {
      final unpaired = basePayload.copyWith(isPaired: false).sanitized();

      await tester.pumpApp(
        BaseView(
          body: SingleChildScrollView(
            child: Column(
              children: [
                CoupleCounterPreviewCards(payload: unpaired),
                PartnerNotePreviewSection(payload: unpaired),
                MoodLongingPreviewSection(payload: unpaired),
                CardEncounterPreviewSection(payload: unpaired),
              ],
            ),
          ),
        ),
      );

      expect(find.textContaining('Marina'), findsNothing);
      expect(find.textContaining('Boa sorte na reunião!'), findsNothing);
      expect(find.text('Convide para ver aqui'), findsWidgets);
    });

    testWidgets('signed-out payload renders the neutral sign-in prompt', (tester) async {
      final signedOut = WidgetPayload.signedOut();

      await tester.pumpApp(
        BaseView(
          body: SingleChildScrollView(
            child: Column(
              children: [
                OwnSmallWidgetsGrid(payload: signedOut, onTap: (_) {}),
                OwnMediumWidgetsCards(payload: signedOut, onTap: (_) {}),
                CoupleCounterPreviewCards(payload: signedOut),
                CardEncounterPreviewSection(payload: signedOut),
              ],
            ),
          ),
        ),
      );

      expect(find.textContaining('Marina'), findsNothing);
      expect(find.text('Toque para entrar'), findsWidgets);
    });
  });
}
