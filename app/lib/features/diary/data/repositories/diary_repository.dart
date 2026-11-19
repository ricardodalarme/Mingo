import 'package:app/features/diary/data/data_sources/remote/diary_data_source.dart';
import 'package:app/features/diary/data/mappers/diary_entry_mapper.dart';
import 'package:app/features/diary/data/models/diary_entry.dart';

class DiaryRepository({required final DiaryDataSource _dataSource}) {
  Future<List<DiaryEntry>> getEntries() async => [
    for (final entry in await _dataSource.getEntries()) entry.toModel(),
  ];

  /// Inserts the first entry for a day, or replaces [id] when it already exists.
  Future<String> saveEntry({
    required DateTime entryDate,
    required String body,
    String? mood,
    String? id,
  }) async {
    if (id != null) {
      await _dataSource.updateEntry(id: id, body: body, mood: mood);

      return id;
    }
    final entry = await _dataSource.insertEntry(entryDate: entryDate, body: body, mood: mood);

    return entry.id;
  }

  Future<void> deleteEntry(String id) => _dataSource.deleteEntry(id);
}
