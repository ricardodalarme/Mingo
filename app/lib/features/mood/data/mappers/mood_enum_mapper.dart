import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';

extension EnumMoodMapper on EnumMood_enum {
  /// Null for a mood this version does not know, so it stays hidden.
  MoodKind? toModel() => switch (this) {
    EnumMood_enum.happy => MoodKind.happy,
    EnumMood_enum.tired => MoodKind.tired,
    EnumMood_enum.sad => MoodKind.sad,
    EnumMood_enum.stressed => MoodKind.stressed,
    EnumMood_enum.loving => MoodKind.loving,
    EnumMood_enum.playful => MoodKind.playful,
    EnumMood_enum.$unknown => null,
  };
}

extension MoodKindMapper on MoodKind {
  EnumMood_enum toRemote() => switch (this) {
    MoodKind.happy => EnumMood_enum.happy,
    MoodKind.tired => EnumMood_enum.tired,
    MoodKind.sad => EnumMood_enum.sad,
    MoodKind.stressed => EnumMood_enum.stressed,
    MoodKind.loving => EnumMood_enum.loving,
    MoodKind.playful => EnumMood_enum.playful,
  };
}

extension EnumMoodNeedMapper on EnumMoodNeed_enum {
  /// Null for a need this version does not know.
  NeedKind? toModel() => switch (this) {
    EnumMoodNeed_enum.listen => NeedKind.listen,
    EnumMoodNeed_enum.opinion => NeedKind.opinion,
    EnumMoodNeed_enum.hug => NeedKind.hug,
    EnumMoodNeed_enum.space => NeedKind.space,
    EnumMoodNeed_enum.chocolate => NeedKind.chocolate,
    EnumMoodNeed_enum.cute_message => NeedKind.cuteMessage,
    EnumMoodNeed_enum.forehead_kiss => NeedKind.foreheadKiss,
    EnumMoodNeed_enum.company => NeedKind.company,
    EnumMoodNeed_enum.rest => NeedKind.rest,
    EnumMoodNeed_enum.$unknown => null,
  };
}

extension NeedKindMapper on NeedKind {
  EnumMoodNeed_enum toRemote() => switch (this) {
    NeedKind.listen => EnumMoodNeed_enum.listen,
    NeedKind.opinion => EnumMoodNeed_enum.opinion,
    NeedKind.hug => EnumMoodNeed_enum.hug,
    NeedKind.space => EnumMoodNeed_enum.space,
    NeedKind.chocolate => EnumMoodNeed_enum.chocolate,
    NeedKind.cuteMessage => EnumMoodNeed_enum.cute_message,
    NeedKind.foreheadKiss => EnumMoodNeed_enum.forehead_kiss,
    NeedKind.company => EnumMoodNeed_enum.company,
    NeedKind.rest => EnumMoodNeed_enum.rest,
  };
}

extension EnumMoodShareMapper on EnumMoodShare_enum {
  /// An unknown audience is treated as private.
  MoodShare toModel() => switch (this) {
    EnumMoodShare_enum.none => MoodShare.none,
    EnumMoodShare_enum.mood => MoodShare.mood,
    EnumMoodShare_enum.mood_need => MoodShare.moodNeed,
    EnumMoodShare_enum.$unknown => MoodShare.none,
  };
}

extension MoodShareMapper on MoodShare {
  EnumMoodShare_enum toRemote() => switch (this) {
    MoodShare.none => EnumMoodShare_enum.none,
    MoodShare.mood => EnumMoodShare_enum.mood,
    MoodShare.moodNeed => EnumMoodShare_enum.mood_need,
  };
}
