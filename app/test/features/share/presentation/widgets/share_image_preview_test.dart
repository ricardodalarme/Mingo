import 'dart:ui' as ui;

import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/share_image_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

const _pngSignature = [0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a];

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('captures the preview as a 1080 by 1350 PNG', (tester) async {
    final boundaryKey = GlobalKey();

    await tester.pumpApp(
      Center(
        child: SizedBox(
          width: sharePreviewMaxWidth,
          child: ShareImagePreview(
            card: ShareCounterCard(since: DateTime(2024, 3, 14)),
            boundaryKey: boundaryKey,
          ),
        ),
      ),
    );
    await tester.pump();

    final png = await tester.runAsync(() => captureShareImage(boundaryKey));

    expect(png, isNotNull);
    expect(png!.sublist(0, _pngSignature.length), _pngSignature);

    final size = await tester.runAsync(() async {
      final codec = await ui.instantiateImageCodec(png);
      final frame = await codec.getNextFrame();
      final size = (frame.image.width, frame.image.height);
      frame.image.dispose();
      codec.dispose();

      return size;
    });

    expect(size, (shareImagePixelWidth, shareImagePixelWidth * 5 ~/ 4));
    expect(size, (1080, 1350));
  });

  testWidgets('the preview keeps the card proportions inside the sheet width', (tester) async {
    await tester.pumpApp(
      Center(
        child: SizedBox(
          width: sharePreviewMaxWidth,
          child: ShareImagePreview(
            card: const ShareQuoteCard(quote: 'Fez café sem eu pedir.', authorName: 'Marina'),
            boundaryKey: GlobalKey(),
          ),
        ),
      ),
    );

    final size = tester.getSize(find.byType(ShareImagePreview));

    expect(size.width, lessThanOrEqualTo(sharePreviewMaxWidth));
    expect(size.height / size.width, closeTo(450 / 360, .02));
  });
}
