import 'package:app/features/cycle/data/data_sources/remote/cycle_data_source.dart';
import 'package:app/features/cycle/data/mappers/sensitive_day_mapper.dart';
import 'package:app/features/cycle/data/models/sensitive_day.dart';
import 'package:logger/logger.dart';

class CycleRepository({required final CycleDataSource _dataSource}) {
  final Logger _logger = Logger('CycleRepository');

  /// Every day the person marked as sensitive, plus the server's local day.
  Future<SensitiveDays> getSensitiveDays() =>
      _run('read sensitive days', () async => (await _dataSource.getSensitiveDays()).toModel());

  Future<void> markDay(DateTime day) =>
      _run('mark a sensitive day', () => _dataSource.markDay(day));

  Future<void> unmarkDay(DateTime day) =>
      _run('unmark a sensitive day', () => _dataSource.unmarkDay(day));

  Future<T> _run<T>(String what, Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, stack) {
      _logger.error('Failed to $what', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
