import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/together/data/models/date_idea_status.dart';
import 'package:app/features/together/data/models/ritual_cadence.dart';

extension EnumRitualCadenceMapper on EnumRitualCadence_enum {
  RitualCadence toModel() => switch (this) {
    EnumRitualCadence_enum.daily => RitualCadence.daily,
    EnumRitualCadence_enum.weekly => RitualCadence.weekly,
    EnumRitualCadence_enum.biweekly => RitualCadence.biweekly,
    EnumRitualCadence_enum.monthly => RitualCadence.monthly,
    EnumRitualCadence_enum.$unknown => throw const FormatException('Unknown ritual cadence'),
  };
}

extension RitualCadenceMapper on RitualCadence {
  EnumRitualCadence_enum toRemote() => switch (this) {
    RitualCadence.daily => EnumRitualCadence_enum.daily,
    RitualCadence.weekly => EnumRitualCadence_enum.weekly,
    RitualCadence.biweekly => EnumRitualCadence_enum.biweekly,
    RitualCadence.monthly => EnumRitualCadence_enum.monthly,
  };
}

extension EnumDateIdeaStatusMapper on EnumDateIdeaStatus_enum {
  DateIdeaStatus toModel() => switch (this) {
    EnumDateIdeaStatus_enum.saved => DateIdeaStatus.saved,
    EnumDateIdeaStatus_enum.planned => DateIdeaStatus.planned,
    EnumDateIdeaStatus_enum.done => DateIdeaStatus.done,
    EnumDateIdeaStatus_enum.$unknown => throw const FormatException('Unknown date idea status'),
  };
}

extension DateIdeaStatusMapper on DateIdeaStatus {
  EnumDateIdeaStatus_enum toRemote() => switch (this) {
    DateIdeaStatus.saved => EnumDateIdeaStatus_enum.saved,
    DateIdeaStatus.planned => EnumDateIdeaStatus_enum.planned,
    DateIdeaStatus.done => EnumDateIdeaStatus_enum.done,
  };
}
