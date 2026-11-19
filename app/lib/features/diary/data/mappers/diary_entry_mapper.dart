import 'package:app/features/diary/data/data_sources/remote/diary_data_source.dart';
import 'package:app/features/diary/data/models/diary_entry.dart';

extension DiaryEntryMapper on JournalEntryRecord {
  DiaryEntry toModel() => DiaryEntry(id: id, entryDate: entryDate, body: body, mood: mood);
}
