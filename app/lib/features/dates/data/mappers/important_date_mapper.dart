import 'package:app/features/dates/data/data_sources/remote/queries/generated/ImportantDates.graphql.dart';
import 'package:app/features/dates/data/mappers/important_date_enum_mapper.dart';
import 'package:app/features/dates/data/models/dates_models.dart';

extension ImportantDateMapper on QueryImportantDatesimportantDates {
  ImportantDate toModel() => ImportantDate(
    id: id,
    title: title,
    kind: kind.toModel(),
    month: month,
    day: day,
    year: year,
    isYearly: yearly,
  );
}
