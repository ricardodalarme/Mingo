import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/card_encounter/widgets/card_encounter_preview_section.dart';
import 'package:app/features/widgets/presentation/couple_counter/widgets/couple_counter_preview_cards.dart';
import 'package:app/features/widgets/presentation/couple_photos/widgets/couple_photos_preview_section.dart';
import 'package:app/features/widgets/presentation/gallery/widgets/gallery_preview_cards.dart';
import 'package:app/features/widgets/presentation/lock_screen/widgets/lock_screen_preview_section.dart';
import 'package:app/features/widgets/presentation/own_medium/widgets/own_medium_cards.dart';
import 'package:app/features/widgets/presentation/own_small/widgets/own_small_grid.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleRawSync('pt');
  });

  group('No-partner, lock-screen and signed-out widget verification pass', () {
    final basePayload = WidgetPayload.fake().copyWith(
      partnerName: 'Marina',
      partnerNote: 'Boa sorte na reunião!',
      nextDateTitle: 'Aniversário',
      ritualTitle: 'Caminhada de domingo',
      dailyIdeaTitle: 'Deixe um bilhete na marmita dele',
    );

    testWidgets('lock screen never shows partner name or personal note even when paired', (
      tester,
    ) async {
      await tester.pumpApp(
        BaseView(
          body: SingleChildScrollView(child: LockScreenPreviewSection(payload: basePayload)),
        ),
      );

      expect(find.textContaining('Marina'), findsNothing);
      expect(find.textContaining('Boa sorte na reunião!'), findsNothing);
      expect(find.textContaining('Momento calmo'), findsWidgets);
    });

    testWidgets('every couple widget family renders the no-partner invite state when unpaired', (
      tester,
    ) async {
      final unpairedPayload = basePayload.copyWith(isPaired: false).sanitized();

      await tester.pumpApp(
        BaseView(
          body: SingleChildScrollView(
            child: Column(
              children: [
                CoupleCounterPreviewCards(payload: unpairedPayload, isDarkPreview: false),
                CouplePhotosPreviewSection(payload: unpairedPayload, isDarkPreview: false),
                CardEncounterPreviewSection(payload: unpairedPayload, isDarkPreview: false),
                GalleryPreviewSection(
                  segment: WidgetGallerySegment.couple,
                  payload: unpairedPayload,
                  onSelectFamily: (_) {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.textContaining('Marina'), findsNothing);
      expect(find.textContaining('Boa sorte na reunião!'), findsNothing);
      expect(find.text('Convide para ver aqui'), findsWidgets);
    });

    testWidgets('signed-out payload renders neutral sign-in prompt across widget families', (
      tester,
    ) async {
      final signedOutPayload = WidgetPayload.signedOut();

      await tester.pumpApp(
        BaseView(
          body: SingleChildScrollView(
            child: Column(
              children: [
                OwnSmallWidgetsGrid(payload: signedOutPayload, isDarkPreview: false),
                OwnMediumWidgetsCards(payload: signedOutPayload, isDarkPreview: false),
                CoupleCounterPreviewCards(payload: signedOutPayload, isDarkPreview: false),
                CouplePhotosPreviewSection(payload: signedOutPayload, isDarkPreview: false),
                CardEncounterPreviewSection(payload: signedOutPayload, isDarkPreview: false),
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
