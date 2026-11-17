import 'package:app/features/memories/data/data_sources/remote/queries/generated/Memories.graphql.dart';
import 'package:app/features/memories/data/models/memory.dart';

extension MemoryMapper on QueryMemoriesmemories {
  Memory toModel() =>
      Memory(id: id, title: title, body: body, happenedOn: happenedOn, place: place);
}
