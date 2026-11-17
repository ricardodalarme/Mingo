import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/capsules/data/data_sources/remote/capsules_data_source.dart';
import 'package:app/features/capsules/data/mappers/capsule_mapper.dart';
import 'package:app/features/capsules/data/models/capsule.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:clock/clock.dart';

class CapsulesRepository({
  required final CapsulesDataSource _dataSource,
  required final TogetherRepository _togetherRepository,
  required final AuthenticationRepository _authenticationRepository,
}) {
  /// The capsules the person can see, soonest first; text is kept only once the day has come.
  Future<List<Capsule>> getCapsules({DateTime? now}) async {
    final moment = now ?? clock.now();
    final today = DateTime(moment.year, moment.month, moment.day);
    final userId = _authenticationRepository.currentUserId;

    return [
      for (final node in await _dataSource.getCapsules())
        node.toModel(userId: userId, today: today),
    ];
  }

  /// Saves a capsule; when [isShared] the partner can read it from [opensOn] on.
  Future<void> add({
    required String id,
    required String body,
    required DateTime opensOn,
    required bool isShared,
  }) async {
    final coupleId = isShared ? await _togetherRepository.getCoupleId() : null;
    await _dataSource.add(id: id, body: body.trim(), opensOn: opensOn, coupleId: coupleId);
  }

  Future<void> delete(String id) async {
    await _dataSource.delete(id);
  }
}
