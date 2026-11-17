import 'package:app/features/agreements/data/data_sources/remote/agreements_data_source.dart';
import 'package:app/features/agreements/data/mappers/agreement_mapper.dart';
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

  Future<List<Agreement>> getAgreements() async {
    final userId = await _togetherRepository.getCurrentUserId();

    return [
      for (final node in await _dataSource.getAgreements()) node.toModel(currentUserId: userId),
    ];
  }

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
        .map((nodes) => [for (final node in nodes) node.toModel(currentUserId: userId)])
        .handleError((Object e, StackTrace stack) {
          _logger.error('The agreements subscription failed', error: e, stackTrace: stack);
        });
  }

  /// Saves the agreement, shared with the partner when the person has one, and returns it.
  Future<Agreement> addAgreement({required String id, required String body}) async {
    final coupleId = await _togetherRepository.getCoupleId();
    final saved = await _dataSource.addAgreement(id: id, body: body.trim(), coupleId: coupleId);

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  Future<Agreement> confirmAgreement(String id) async {
    final saved = await _dataSource.confirmAgreement(id);

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  Future<void> archiveAgreement(String id) =>
      _dataSource.archiveAgreement(id: id, archivedAt: clock.now());
}
