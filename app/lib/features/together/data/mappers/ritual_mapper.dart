import 'package:app/features/together/data/data_sources/remote/queries/generated/Rituals.graphql.dart';
import 'package:app/features/together/data/mappers/together_enum_mapper.dart';
import 'package:app/features/together/data/models/ritual.dart';

/// The hour a ritual falls on when the server stored no time.
const int defaultRitualHour = 19;

extension RitualMapper on QueryRitualsrituals {
  Ritual toModel() => Ritual(
    id: id,
    title: title,
    cadence: cadence.toModel(),
    weekday: weekday,
    hour: _hourOf(atTime),
    hasReminder: reminder,
    plannerId: plannerId,
    lastDoneOn: logs.firstOrNull?.doneOn,
  );
}

int _hourOf(String? time) =>
    time == null ? defaultRitualHour : int.tryParse(time.split(':').first) ?? defaultRitualHour;
