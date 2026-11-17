import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/together/data/data_sources/remote/queries/generated/Rituals.graphql.dart';
import 'package:app/features/together/data/mappers/ritual_mapper.dart';
import 'package:app/features/together/data/models/ritual_cadence.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  QueryRitualsrituals node({
    String? atTime,
    int? weekday,
    List<QueryRitualsritualslogs> logs = const [],
  }) => QueryRitualsrituals(
    id: 'r1',
    title: 'Jantar de sexta',
    cadence: EnumRitualCadence_enum.weekly,
    weekday: weekday,
    atTime: atTime,
    reminder: true,
    plannerId: 'me',
    logs: logs,
  );

  test('copies the fields and maps the cadence', () {
    final ritual = node(weekday: 5, atTime: '20:30:00').toModel();

    expect(ritual.id, 'r1');
    expect(ritual.title, 'Jantar de sexta');
    expect(ritual.cadence, RitualCadence.weekly);
    expect(ritual.weekday, 5);
    expect(ritual.hasReminder, isTrue);
    expect(ritual.plannerId, 'me');
  });

  test('the hour is the first part of the stored time', () {
    expect(node(atTime: '08:15:00').toModel().hour, 8);
  });

  test('a missing or unreadable time falls back to the default hour', () {
    expect(node().toModel().hour, defaultRitualHour);
    expect(node(atTime: 'later').toModel().hour, defaultRitualHour);
  });

  test('the last done day is the newest log, or none', () {
    final done = DateTime.utc(2026, 3, 6);

    expect(node(logs: [QueryRitualsritualslogs(doneOn: done)]).toModel().lastDoneOn, done);
    expect(node().toModel().lastDoneOn, isNull);
  });
}
