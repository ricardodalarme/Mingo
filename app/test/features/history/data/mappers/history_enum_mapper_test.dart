import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/dates/data/models/important_date_kind.dart';
import 'package:app/features/history/data/mappers/history_enum_mapper.dart';
import 'package:app/features/history/data/models/history_models.dart';
import 'package:app/features/history/data/models/memory_origin.dart';
import 'package:app/features/history/data/models/story_event_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a date precision survives a trip to the remote enum and back', () {
    for (final value in MilestoneDatePrecision.values.where(
      (v) => v != MilestoneDatePrecision.unknown,
    )) {
      expect(value.toRemote().toModel(), value);
    }
  });
  test('an unknown precision is read as a whole day', () {
    expect(EnumDatePrecision_enum.$unknown.toModel(), MilestoneDatePrecision.day);
  });

  test('a story event kind maps to a milestone and back', () {
    for (final value in StoryEventKind.values) {
      expect(value.toRemote().toMilestoneKind().toStoryEventKind(), value);
    }
  });

  test('an important date reads as a first, a trip or a custom milestone', () {
    expect(EnumImportantDateKind_enum.first.toMilestoneKind(), MilestoneKind.first);
    expect(EnumImportantDateKind_enum.trip.toMilestoneKind(), MilestoneKind.trip);
    expect(EnumImportantDateKind_enum.birthday.toMilestoneKind(), MilestoneKind.custom);
  });

  test('a plain memory with a place reads as a trip', () {
    expect(EnumMemoryOrigin_enum.manual.toMilestoneKind(place: 'Lisboa'), MilestoneKind.trip);
    expect(EnumMemoryOrigin_enum.manual.toMilestoneKind(), MilestoneKind.custom);
    expect(EnumMemoryOrigin_enum.first.toMilestoneKind(place: 'Lisboa'), MilestoneKind.first);
  });

  test('every memory origin has a stored value', () {
    for (final origin in MemoryOrigin.values) {
      expect(origin.toRemote(), isNot(EnumMemoryOrigin_enum.$unknown));
    }
  });

  test('a milestone is stored as an important date or a story event', () {
    expect(MilestoneKind.first.toImportantDateKind(), ImportantDateKind.first);
    expect(MilestoneKind.met.toImportantDateKind(), ImportantDateKind.relationship);
    expect(MilestoneKind.home.toImportantDateKind(), ImportantDateKind.custom);
    expect(MilestoneKind.engaged.toStoryEventKind(), StoryEventKind.engaged);
    expect(MilestoneKind.trip.toStoryEventKind(), StoryEventKind.custom);
  });
}
