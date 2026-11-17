import 'package:app/features/memories/data/data_sources/remote/memories_data_source.dart';
import 'package:app/features/memories/data/mappers/memory_mapper.dart';
import 'package:app/features/memories/data/models/memory.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';

class MemoriesRepository({
  required final MemoriesDataSource _dataSource,
  required final TogetherRepository _togetherRepository,
}) {
  Future<List<Memory>> getMemories() async => [
    for (final node in await _dataSource.getMemories()) node.toModel(),
  ];

  /// Saves a memory shared with the partner when there is one; the client [id] makes retries safe.
  Future<void> addMemory({
    required String id,
    required String title,
    required DateTime happenedOn,
    String? body,
    String? place,
  }) async => _dataSource.addMemory(
    id: id,
    title: title.trim(),
    body: body == null || body.trim().isEmpty ? null : body.trim(),
    happenedOn: DateTime(happenedOn.year, happenedOn.month, happenedOn.day),
    place: place == null || place.trim().isEmpty ? null : place.trim(),
    coupleId: await _togetherRepository.getCoupleId(),
  );

  Future<void> deleteMemory(String id) => _dataSource.deleteMemory(id);
}
