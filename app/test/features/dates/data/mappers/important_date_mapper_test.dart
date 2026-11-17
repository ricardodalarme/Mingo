import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/queries/generated/ImportantDates.graphql.dart';
import 'package:app/features/dates/data/mappers/important_date_mapper.dart';
import 'package:app/features/dates/data/models/important_date_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  QueryImportantDatesimportantDates node({int? year, bool yearly = true}) =>
      QueryImportantDatesimportantDates(
        id: 'd1',
        title: 'Aniversário',
        kind: EnumImportantDateKind_enum.birthday,
        month: 7,
        day: 14,
        year: year,
        yearly: yearly,
      );

  test('a date keeps its title, day and kind', () {
    final date = node(year: 2020).toModel();

    expect(date.id, 'd1');
    expect(date.title, 'Aniversário');
    expect(date.kind, ImportantDateKind.birthday);
    expect(date.month, 7);
    expect(date.day, 14);
    expect(date.year, 2020);
  });

  test('a date with no year has none, and the yearly flag is kept', () {
    expect(node().toModel().year, isNull);
    expect(node().toModel().isYearly, isTrue);
    expect(node(yearly: false).toModel().isYearly, isFalse);
  });
}
