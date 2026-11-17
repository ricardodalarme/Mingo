import 'package:app/features/programs/data/data_sources/remote/programs_data_source.dart';
import 'package:app/features/programs/data/models/diary_entry.dart';

extension DiaryEntryMapper on JournalEntryRecord {
  DiaryEntry toModel() => DiaryEntry(id: id, entryDate: entryDate, body: body, mood: mood);
}
