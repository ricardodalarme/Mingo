import 'package:app/features/dates/data/data_sources/remote/queries/generated/Holidays.graphql.dart';
import 'package:app/features/dates/data/models/dates_models.dart';

extension HolidayMapper on QueryHolidayscontentItems {
  /// The holiday, or null when the catalog gives it no fixed day.
  Holiday? toModel() {
    final month = this.month;
    final day = this.day;
    if (month == null || day == null) return null;

    return Holiday(slug: slug, title: title, month: month, day: day);
  }
}
