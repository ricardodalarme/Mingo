import 'package:app/features/agreements/data/data_sources/remote/agreements_data_source.dart';
import 'package:app/features/agreements/data/data_sources/remote/fragments/generated/AgreementFragment.graphql.dart';
import 'package:app/features/agreements/data/models/agreement.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:clock/clock.dart';
import 'package:logger/logger.dart';

class AgreementsRepository({
  required final AgreementsDataSource _dataSource,
  required final TogetherRepository _togetherRepository,
}) {
  final Logger _logger = Logger('AgreementsRepository');

  /// The id of the couple the person is in, or null when they are on their own.
  Future<String?> getCoupleId() => _togetherRepository.getCoupleId();

  Future<List<Agreement>> getAgreements() => _run('read agreements', () async {
    final userId = await _togetherRepository.getCurrentUserId();

    return [
      for (final node in await _dataSource.getAgreements()) _toModel(node, currentUserId: userId),
    ];
  });

  /// Emits the open agreements now and each time the partner or the person changes one.
  ///
  /// A failed event is logged and skipped, so a screen keeps what it shows.
  Stream<List<Agreement>> watchAgreements() async* {
    final String? userId;
    try {
      userId = await _togetherRepository.getCurrentUserId();
    } catch (e, stack) {
      _logger.error('Failed to start the agreements subscription', error: e, stackTrace: stack);

      return;
    }

    yield* _dataSource
        .watchAgreements()
        .map((nodes) => [for (final node in nodes) _toModel(node, currentUserId: userId)])
        .handleError((Object e, StackTrace stack) {
          _logger.error('The agreements subscription failed', error: e, stackTrace: stack);
        });
  }

  /// Saves the agreement, shared with the partner when the person has one, and returns it.
  Future<Agreement> addAgreement({required String id, required String body}) =>
      _run('add an agreement', () async {
        final coupleId = await _togetherRepository.getCoupleId();
        final saved = await _dataSource.addAgreement(id: id, body: body.trim(), coupleId: coupleId);

        return _toModel(saved, currentUserId: await _togetherRepository.getCurrentUserId());
      });

  Future<Agreement> confirmAgreement(String id) => _run('confirm an agreement', () async {
    final saved = await _dataSource.confirmAgreement(id);

    return _toModel(saved, currentUserId: await _togetherRepository.getCurrentUserId());
  });

  Future<void> archiveAgreement(String id) => _run(
    'archive an agreement',
    () => _dataSource.archiveAgreement(id: id, archivedAt: clock.now()),
  );

  Agreement _toModel(FragmentAgreementFragment node, {required String? currentUserId}) => Agreement(
    id: node.id,
    body: node.body,
    isMine: node.authorId == currentUserId,
    isShared: node.coupleId != null,
    isConfirmed: node.confirmedAt != null,
  );

  Future<T> _run<T>(String what, Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, stack) {
      _logger.error('Failed to $what', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
