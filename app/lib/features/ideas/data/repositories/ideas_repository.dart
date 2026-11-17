import 'package:app/features/ideas/data/data_sources/local/ideas_local_data_source.dart';
import 'package:app/features/ideas/data/data_sources/remote/ideas_data_source.dart';
import 'package:app/features/ideas/data/mappers/idea_mapper.dart';
import 'package:app/features/ideas/data/models/idea.dart';

class IdeasRepository({
  required final IdeasDataSource _dataSource,
  required final IdeasLocalDataSource _localDataSource,
}) {
  /// The ideas for [locale] in editorial order.
  Future<List<Idea>> getIdeas(String locale) async {
    final result = await _dataSource.getIdeas(locale);

    return [for (final node in result) node.toModel()];
  }

  /// Marks an idea as done; doing it again changes nothing.
  Future<void> markDone(String slug) {
    final done = _localDataSource.readDone();
    if (!done.add(slug)) return Future.value();

    return _localDataSource.writeDone(done);
  }

  bool isDone(String slug) => _localDataSource.readDone().contains(slug);
}
