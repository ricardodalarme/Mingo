import 'package:app/features/today/data/data_sources/remote/queries/generated/TodayHome.graphql.dart';
import 'package:app/features/today/data/mappers/today_home_mapper.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:flutter_test/flutter_test.dart';

QueryTodayHome _query({
  List<QueryTodayHometoday> today = const [],
  List<QueryTodayHomequestion> question = const [],
}) => QueryTodayHome(today: today, question: question, idea: const []);

void main() {
  test('maps today and the week slip days', () {
    final model = _query(
      today: [
        QueryTodayHometoday(localDate: DateTime(2026, 11, 10), slipDays: [DateTime(2026, 11, 9)]),
      ],
    ).toModel();

    expect(model?.localDate, DateTime(2026, 11, 10));
    expect(model?.slipDays, [DateTime(2026, 11, 9)]);
  });

  test('a row without today is null', () {
    expect(_query().toModel(), isNull);
  });

  test('a partner id is what makes the person paired', () {
    expect(_query(today: [QueryTodayHometoday(partnerId: 'p1')]).toModel()?.isPaired, isTrue);
    expect(_query(today: [QueryTodayHometoday()]).toModel()?.isPaired, isFalse);
  });

  test('maps the partner id and keeps it on the cache round trip', () {
    final model = _query(today: [QueryTodayHometoday(partnerId: 'p1')]).toModel();

    expect(model?.partnerId, 'p1');
    expect(TodayHome.fromMap(model!.toMap()), model);
  });
}
