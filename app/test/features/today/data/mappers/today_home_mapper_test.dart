import 'package:app/features/today/data/data_sources/remote/queries/generated/TodayHome.graphql.dart';
import 'package:app/features/today/data/mappers/today_home_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

QueryTodayHome _query({QueryTodayHometoday? today}) => QueryTodayHome(today: today);

void main() {
  test('maps today and the week slip days', () {
    final model = _query(
      today: QueryTodayHometoday(
        localDate: DateTime(2026, 11, 10),
        slipDays: [DateTime(2026, 11, 9), null],
      ),
    ).toModel();

    expect(model?.localDate, DateTime(2026, 11, 10));
    expect(model?.slipDays, [DateTime(2026, 11, 9)]);
  });

  test('a row without today is null', () {
    expect(_query().toModel(), isNull);
  });
}
