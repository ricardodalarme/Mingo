import 'package:app/features/weekly_review/data/data_sources/remote/weekly_review_data_source.dart';
import 'package:app/features/weekly_review/data/mappers/weekly_review_mapper.dart';
import 'package:app/features/weekly_review/data/models/weekly_review.dart';

class WeeklyReviewRepository({required final WeeklyReviewDataSource _dataSource}) {
  Future<WeeklyReview> get() async {
    final row = await _dataSource.get();

    return row.toModel();
  }
}
