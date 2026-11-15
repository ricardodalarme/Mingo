import 'package:app/features/memories/data/data_sources/remote/memories_data_source.dart';
import 'package:app/features/memories/data/models/drawn_slip.dart';
import 'package:app/features/memories/data/models/memory.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:logger/logger.dart';

class MemoriesRepository({
  required final MemoriesDataSource _dataSource,
  required final TogetherRepository _togetherRepository,
}) {
  final Logger _logger = Logger('MemoriesRepository');

  Future<List<Memory>> getMemories() => _run(
    'read memories',
    () async => [
      for (final node in await _dataSource.getMemories())
        Memory(
          id: node.id,
          title: node.title,
          body: node.body,
          happenedOn: node.happenedOn,
          place: node.place,
        ),
    ],
  );

  /// Saves a memory shared with the partner when there is one; the client [id] makes retries safe.
  Future<void> addMemory({
    required String id,
    required String title,
    required DateTime happenedOn,
    String? body,
    String? place,
  }) => _run(
    'add a memory',
    () async => _dataSource.addMemory(
      id: id,
      title: title.trim(),
      body: body == null || body.trim().isEmpty ? null : body.trim(),
      happenedOn: DateTime(happenedOn.year, happenedOn.month, happenedOn.day),
      place: place == null || place.trim().isEmpty ? null : place.trim(),
      coupleId: await _togetherRepository.getCoupleId(),
    ),
  );

  Future<void> deleteMemory(String id) =>
      _run('delete a memory', () => _dataSource.deleteMemory(id));

  /// One random slip from the jar, or null when it is empty.
  Future<DrawnSlip?> drawFromJar() => _run('draw from the jar', () async {
    final slip = await _dataSource.drawFromJar();

    return slip == null ? null : DrawnSlip(id: slip.id, body: slip.body);
  });

  Future<T> _run<T>(String what, Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, stack) {
      _logger.error('Failed to $what', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
