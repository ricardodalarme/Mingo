import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/dates/data/models/important_date_kind.dart';
import 'package:app/features/history/data/models/history_models.dart';
import 'package:app/features/history/data/models/memory_origin.dart';
import 'package:app/features/history/data/models/story_event_kind.dart';

extension EnumDatePrecisionMapper on EnumDatePrecision_enum {
  /// An unknown precision is read as a whole day.
  MilestoneDatePrecision toModel() => switch (this) {
    EnumDatePrecision_enum.day || EnumDatePrecision_enum.$unknown => MilestoneDatePrecision.day,
    EnumDatePrecision_enum.month => MilestoneDatePrecision.month,
    EnumDatePrecision_enum.year => MilestoneDatePrecision.year,
  };
}

extension MilestoneDatePrecisionMapper on MilestoneDatePrecision {
  /// A milestone with an unknown date is stored as an important date, which has no precision.
  EnumDatePrecision_enum toRemote() => switch (this) {
    MilestoneDatePrecision.day || MilestoneDatePrecision.unknown => EnumDatePrecision_enum.day,
    MilestoneDatePrecision.month => EnumDatePrecision_enum.month,
    MilestoneDatePrecision.year => EnumDatePrecision_enum.year,
  };
}

extension EnumStoryEventKindMapper on EnumStoryEventKind_enum {
  MilestoneKind toMilestoneKind() => switch (this) {
    EnumStoryEventKind_enum.met => MilestoneKind.met,
    EnumStoryEventKind_enum.dating => MilestoneKind.dating,
    EnumStoryEventKind_enum.engaged => MilestoneKind.engaged,
    EnumStoryEventKind_enum.married => MilestoneKind.married,
    EnumStoryEventKind_enum.custom || EnumStoryEventKind_enum.$unknown => MilestoneKind.custom,
  };
}

extension StoryEventKindMapper on StoryEventKind {
  EnumStoryEventKind_enum toRemote() => switch (this) {
    StoryEventKind.met => EnumStoryEventKind_enum.met,
    StoryEventKind.dating => EnumStoryEventKind_enum.dating,
    StoryEventKind.engaged => EnumStoryEventKind_enum.engaged,
    StoryEventKind.married => EnumStoryEventKind_enum.married,
    StoryEventKind.custom => EnumStoryEventKind_enum.custom,
  };
}

extension EnumImportantDateKindMilestoneMapper on EnumImportantDateKind_enum {
  MilestoneKind toMilestoneKind() => switch (this) {
    EnumImportantDateKind_enum.first => MilestoneKind.first,
    EnumImportantDateKind_enum.trip => MilestoneKind.trip,
    _ => MilestoneKind.custom,
  };
}

extension EnumMemoryOriginMapper on EnumMemoryOrigin_enum {
  /// A plain memory with a place reads as a trip.
  MilestoneKind toMilestoneKind({String? place}) {
    final hasPlace = place != null && place.trim().isNotEmpty;
    return switch (this) {
      EnumMemoryOrigin_enum.manual when hasPlace => MilestoneKind.trip,
      EnumMemoryOrigin_enum.first => MilestoneKind.first,
      _ => MilestoneKind.custom,
    };
  }
}

extension MemoryOriginMapper on MemoryOrigin {
  EnumMemoryOrigin_enum toRemote() => switch (this) {
    MemoryOrigin.manual => EnumMemoryOrigin_enum.manual,
    MemoryOrigin.slip => EnumMemoryOrigin_enum.slip,
    MemoryOrigin.card => EnumMemoryOrigin_enum.card,
    MemoryOrigin.question => EnumMemoryOrigin_enum.question,
    MemoryOrigin.game => EnumMemoryOrigin_enum.game,
    MemoryOrigin.mission => EnumMemoryOrigin_enum.mission,
    MemoryOrigin.share => EnumMemoryOrigin_enum.share,
    MemoryOrigin.chat => EnumMemoryOrigin_enum.chat,
    MemoryOrigin.first => EnumMemoryOrigin_enum.first,
  };
}

extension MilestoneKindDateMapper on MilestoneKind {
  /// The important date kind a milestone with an unknown date is stored as.
  ImportantDateKind toImportantDateKind() => switch (this) {
    MilestoneKind.first => ImportantDateKind.first,
    MilestoneKind.trip => ImportantDateKind.trip,
    MilestoneKind.met ||
    MilestoneKind.dating ||
    MilestoneKind.engaged ||
    MilestoneKind.married => ImportantDateKind.relationship,
    MilestoneKind.home || MilestoneKind.custom => ImportantDateKind.custom,
  };

  /// The story event kind a milestone with a known date is stored as.
  StoryEventKind toStoryEventKind() => switch (this) {
    MilestoneKind.met => StoryEventKind.met,
    MilestoneKind.dating => StoryEventKind.dating,
    MilestoneKind.engaged => StoryEventKind.engaged,
    MilestoneKind.married => StoryEventKind.married,
    MilestoneKind.first ||
    MilestoneKind.trip ||
    MilestoneKind.home ||
    MilestoneKind.custom => StoryEventKind.custom,
  };
}
