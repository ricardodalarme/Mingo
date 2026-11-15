import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/share_card_canvas.dart';
import 'package:app/features/share/presentation/widgets/share_card_frame.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/rendering.dart' show RenderRepaintBoundary;

/// The width of an exported image, in pixels.
const int shareImagePixelWidth = 1080;

/// The widest a preview grows inside the sheet.
const double sharePreviewMaxWidth = 300;

/// A scaled preview of [card], framed by the app's card ring.
class const ShareImagePreview({
  required final ShareCard card,
  required final GlobalKey boundaryKey,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCardRing(
      child: AspectRatio(
        aspectRatio: shareCardWidth / shareCardHeight,
        child: FittedBox(
          child: RepaintBoundary(
            key: boundaryKey,
            child: ShareCardCanvas(card: card),
          ),
        ),
      ),
    );
  }
}

/// Renders the card inside [boundaryKey] to a PNG of 1080 by 1350 pixels.
Future<Uint8List> captureShareImage(GlobalKey boundaryKey) async {
  final renderObject = boundaryKey.currentContext?.findRenderObject();
  if (renderObject is! RenderRepaintBoundary) {
    throw StateError('The share card is not on screen.');
  }

  final image = await renderObject.toImage(
    pixelRatio: shareImagePixelWidth / renderObject.size.width,
  );
  try {
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    if (data == null) throw StateError('The share card could not be encoded.');

    return data.buffer.asUint8List();
  } finally {
    image.dispose();
  }
}
