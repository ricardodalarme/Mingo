import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/gallery/widgets/gallery_preview_cards.dart';
import 'package:app/features/widgets/presentation/lock_screen/widgets/lock_screen_preview_section.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleRawSync('pt');
  });

  final payload = WidgetPayload.fake().copyWith(cardState: 'ready');

  testWidgets('lock screen shows the neutral phrase, never the card status', (tester) async {
    await tester.pumpApp(
      BaseView(
        body: SingleChildScrollView(
          child: LockScreenPreviewSection(payload: payload.copyWith(onLockScreen: true)),
        ),
      ),
    );

    expect(find.textContaining('Chegou um cartão'), findsNothing);
    expect(find.text('Momento calmo'), findsWidgets);
  });

  testWidgets('lock screen shows a neutral card when the setting is off', (tester) async {
    await tester.pumpApp(
      BaseView(
        body: SingleChildScrollView(
          child: LockScreenPreviewSection(payload: payload.copyWith(onLockScreen: false)),
        ),
      ),
    );

    expect(
      find.text('O widget da tela de bloqueio está desativado nas configurações.'),
      findsOneWidget,
    );
  });

  testWidgets('gallery lock-screen card stays neutral in discreet mode', (tester) async {
    final discreet = payload.copyWith(discreet: true).sanitized();

    await tester.pumpApp(
      BaseView(
        body: SingleChildScrollView(
          child: GalleryPreviewSection(
            segment: WidgetGallerySegment.own,
            payload: discreet,
            onSelectFamily: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Lembrete calmo · Sem nomes'), findsWidgets);
  });
}
