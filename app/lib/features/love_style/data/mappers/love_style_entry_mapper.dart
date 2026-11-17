import 'package:app/features/love_style/data/data_sources/remote/love_style_data_source.dart';
import 'package:app/features/love_style/data/models/love_style_entry.dart';

extension LoveStyleEntryMapper on LoveStyleRecord {
  LoveStyleEntry toModel() => LoveStyleEntry(id: id, ranked: ranked, sharedAt: sharedAt);
}
