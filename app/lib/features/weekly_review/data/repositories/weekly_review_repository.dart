import 'package:app/features/weekly_review/data/data_sources/remote/weekly_review_data_source.dart';
import 'package:app/features/weekly_review/data/mappers/weekly_review_mapper.dart';
import 'package:app/features/weekly_review/data/models/weekly_review.dart';
import 'package:logger/logger.dart';

class WeeklyReviewRepository({required final WeeklyReviewDataSource _dataSource}) {
  final Logger _logger = Logger('WeeklyReviewRepository');

  Future<WeeklyReview> get() async {
    try {
      final row = await _dataSource.get();

      return row.toModel();
    } catch (e, stack) {
      _logger.error('Failed to load the weekly review', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
