import 'dart:typed_data';

import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:app/features/story/data/models/story_card.dart';
import 'package:share_service/share_service.dart';

class StoryRepository({
  required final HistoryRepository _historyRepository,
  required final ShareService _shareService,
}) {
  /// The numbers for the image, or null when there is no together-since date to count from.
  ///
  /// Also returns the names so the person can choose to show them; they are never added by default.
  Future<({StoryCard? card, String names})> getStory() async {
    final overview = await _historyRepository.getOverview();
    final names = [overview.selfName, ?overview.partnerName].where((n) => n.isNotEmpty).join(' & ');
    if (overview.togetherSince == null) return (card: null, names: names);

    final numbers = overview.numbers;

    return (
      card: StoryCard(
        daysTogether: numbers.daysTogether,
        years: numbers.years,
        months: numbers.months,
      ),
      names: names,
    );
  }

  /// Opens the share sheet with the rendered [png]; the temporary file is removed afterwards.
  Future<void> share(Uint8List png) async {
    final file = await _shareService.writeTemporaryFile(fileName: 'story.png', bytes: png);
    try {
      await _shareService.shareFile(file: file, mimeType: 'image/png');
    } finally {
      await _shareService.deleteTemporaryFile(file);
    }
  }
}
