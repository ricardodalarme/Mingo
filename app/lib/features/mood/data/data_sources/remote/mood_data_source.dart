import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/mood/data/data_sources/remote/mutations/generated/InsertMood.graphql.dart';
import 'package:app/features/mood/data/data_sources/remote/mutations/generated/UpdateMood.graphql.dart';
import 'package:app/features/mood/data/data_sources/remote/queries/generated/TodayMood.graphql.dart';
import 'package:network/network.dart';

/// A mood row with its raw server values, before the domain mapping.
typedef MoodRecord = ({
  String id,
  DateTime day,
  EnumMood_enum mood,
  EnumMoodNeed_enum? need,
  EnumMoodShare_enum share,
});

/// The partner's shared mood with its raw server values, before the domain mapping.
typedef PartnerMoodRecord = ({DateTime? day, EnumMood_enum? mood, EnumMoodNeed_enum? need});

/// The server's local day, the partner's name, today's own mood and the partner's shared mood.
typedef MoodTodayRecord = ({
  DateTime day,
  bool hasPartner,
  String? partnerName,
  MoodRecord? mood,
  PartnerMoodRecord? partnerMood,
});

class MoodDataSource({required final GQLClient _client}) {
  /// Reads the server local day, today's own mood and the partner's shared mood in one request.
  Future<MoodTodayRecord> getTodayMood() async {
    final response = await _client.query(
      OptionsQueryTodayMood(fetchPolicy: FetchPolicy.networkOnly),
    );
    final data = validateResponseData<QueryTodayMood, QueryTodayMood>(response);
    final today = data.today.firstOrNull;
    final localDate = today?.localDate;
    if (today == null || localDate == null) throw const NoDataException();

    final node = data.moods.firstOrNull;
    final mood = node != null && node.day == localDate ? node.toRecord() : null;
    final shared = today.partner?.sharedMood;
    final partnerMood = shared != null && shared.day == localDate ? shared.toRecord() : null;

    return (
      day: localDate,
      hasPartner: today.partner != null,
      partnerName: today.partnerName,
      mood: mood,
      partnerMood: partnerMood,
    );
  }

  Future<MoodRecord> insertMood({
    required EnumMood_enum mood,
    required EnumMoodNeed_enum? need,
    required EnumMoodShare_enum share,
    required DateTime day,
  }) async {
    final response = await _client.mutate(
      OptionsMutationInsertMood(
        variables: VariablesMutationInsertMood(mood: mood, need: need, share: share, day: day),
      ),
    );
    final data = validateResponseData<MutationInsertMood, MutationInsertMood>(response);
    final record = data.insertMoodsOne;
    if (record == null) throw const NoDataException();

    return record.toRecord();
  }

  /// Saves today's mood. A null [need] clears it.
  Future<MoodRecord> updateMood({
    required String id,
    required EnumMood_enum mood,
    required EnumMoodNeed_enum? need,
    required EnumMoodShare_enum share,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateMood(
        // fromJson keeps a null need in the payload; the generated constructor drops it,
        // which would leave the old need in place.
        variables: VariablesMutationUpdateMood.fromJson({
          'id': id,
          'changes': {'mood': mood.toJson(), 'need': need?.toJson(), 'share': share.toJson()},
        }),
      ),
    );
    final data = validateResponseData<MutationUpdateMood, MutationUpdateMood>(response);
    final record = data.updateMoodsByPk;
    if (record == null) throw const NoDataException();

    return record.toRecord();
  }
}

extension on QueryTodayMoodmoods {
  MoodRecord toRecord() => (id: id, day: day, mood: mood, need: need, share: share);
}

extension on QueryTodayMoodtodaypartnersharedMood {
  PartnerMoodRecord toRecord() => (day: day, mood: mood, need: need);
}

extension on MutationInsertMoodinsertMoodsOne {
  MoodRecord toRecord() => (id: id, day: day, mood: mood, need: need, share: share);
}

extension on MutationUpdateMoodupdateMoodsByPk {
  MoodRecord toRecord() => (id: id, day: day, mood: mood, need: need, share: share);
}
