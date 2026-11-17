import 'package:app/features/fight_style/data/data_sources/remote/fight_style_data_source.dart';
import 'package:core/core.dart';
import 'package:uuid/uuid.dart';

class FightStyleRepository({required final FightStyleDataSource _dataSource}) {
  final Uuid _uuid = const Uuid();

  /// The ranked patterns already saved, or null when the exercise was never finished.
  Future<List<String>?> getSavedRanked() async {
    return (await _dataSource.getResult())?.ranked;
  }

  /// Stores the latest ranking, updating the saved row so a retake replaces it.
  Future<void> saveRanked(List<String> ranked) async {
    final saved = await _dataSource.getResult();
    if (saved != null) {
      await _dataSource.updateResult(id: saved.id, ranked: ranked);

      return;
    }

    try {
      await _dataSource.insertResult(ranked);
    } on LocalizedException catch (exception) {
      if (!_isUniqueViolation(exception)) rethrow;
      final raced = await _dataSource.getResult();
      if (raced == null) rethrow;
      await _dataSource.updateResult(id: raced.id, ranked: ranked);
    }
  }

  /// Saves the result description as a private repair tool, with no partner sharing.
  Future<void> addRepairTool(String note) async {
    await _dataSource.addRepairTool(id: _uuid.v4(), note: note.trim());
  }

  bool _isUniqueViolation(LocalizedException exception) =>
      exception.l10nKey == '23505' || exception.l10nKey.toLowerCase().contains('duplicate key');
}
