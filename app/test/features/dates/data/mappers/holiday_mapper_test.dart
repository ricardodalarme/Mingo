import 'package:app/features/dates/data/data_sources/remote/queries/generated/Holidays.graphql.dart';
import 'package:app/features/dates/data/mappers/holiday_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a holiday with a fixed day keeps its slug, title and day', () {
    final holiday = QueryHolidayscontentItems(
      slug: 'natal',
      title: 'Natal',
      month: 12,
      day: 25,
    ).toModel()!;

    expect(holiday.slug, 'natal');
    expect(holiday.title, 'Natal');
    expect(holiday.month, 12);
    expect(holiday.day, 25);
  });

  test('a holiday with no fixed day is left out', () {
    expect(
      QueryHolidayscontentItems(slug: 'carnaval', title: 'Carnaval', month: 2).toModel(),
      isNull,
    );
    expect(
      QueryHolidayscontentItems(slug: 'carnaval', title: 'Carnaval', day: 14).toModel(),
      isNull,
    );
    expect(QueryHolidayscontentItems(slug: 'carnaval', title: 'Carnaval').toModel(), isNull);
  });
}
