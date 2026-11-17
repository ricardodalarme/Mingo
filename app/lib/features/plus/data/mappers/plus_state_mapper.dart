import 'package:app/features/plus/data/data_sources/remote/queries/generated/MyPlus.graphql.dart';
import 'package:app/features/plus/data/mappers/plus_enum_mapper.dart';
import 'package:app/features/plus/data/models/plus_state.dart';

extension PlusStateMapper on QueryMyPlusplusStates {
  /// What the person has; a missing count reads as none left.
  PlusState toModel() => PlusState(
    hasPlus: hasPlus ?? false,
    isPaidByPartner: paidByPartner ?? false,
    gamesLeft: gamesLeftThisWeek ?? 0,
    ritualsLeft: ritualsLeft ?? 0,
    listsLeft: listsLeft ?? 0,
    plan: entitlement?.plan.toModel(),
    status: entitlement?.status.toModel(),
  );
}
