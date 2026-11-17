import 'dart:typed_data';

import 'package:share_service/share_service.dart';

class ShareImageRepository({required final ShareService _shareService}) {
  /// Writes the rendered [png] to a temporary file and opens the share sheet.
  ///
  /// The file is removed after the sheet closes; nothing is uploaded.
  Future<void> share(Uint8List png) async {
    final file = await _shareService.writeTemporaryFile(fileName: 'share-image.png', bytes: png);
    try {
      await _shareService.shareFile(file: file, mimeType: 'image/png');
    } finally {
      await _shareService.deleteTemporaryFile(file);
    }
  }
}
