import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/fragments/generated/SpiceChallengeFragment.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/AnswerSpiceDesire.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/GrantAdultConsent.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SetSpiceEnabled.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SetSpiceSettings.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SpiceChallenge.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SpiceChallengeAct.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SpiceNextCard.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SpiceOff.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SpiceRespondCard.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/MySpiceAnswers.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/MySpiceSettings.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceDesires.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceMatches.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceState.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceTexts.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/subscriptions/generated/WatchSpiceChallenge.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/subscriptions/generated/WatchSpiceState.graphql.dart';
import 'package:network/network.dart';

typedef SpiceStateRecord = ({String state, int? myLevel, int? coupleLevel});

class SpiceDataSource({required final GQLClient _client}) {
  Future<QuerySpiceStatespiceState> getState() async {
    final response = await _client.query(
      OptionsQuerySpiceState(fetchPolicy: FetchPolicy.networkOnly),
    );
    final rows = validateResponseData(response, getData: (data) => data.spiceState);
    if (rows.isEmpty) throw const NoDataException();

    return rows.first;
  }

  /// Emits the mode now and each time either person switches it on or off or changes a level.
  Stream<SpiceStateRecord> watchState() {
    return _client.subscribe(OptionsSubscriptionWatchSpiceState()).mapResponseData((data) {
      final row = data.spiceState.firstOrNull;
      if (row == null) return null;

      return (state: row.state, myLevel: row.myLevel, coupleLevel: row.coupleLevel);
    });
  }

  /// Emits the couple's current challenge now and each time it is accepted, done or swapped;
  /// null when there is none.
  Stream<FragmentSpiceChallengeFragment?> watchChallenge() {
    return _client
        .subscribe(OptionsSubscriptionWatchSpiceChallenge())
        .mapResponseData((data) => List<FragmentSpiceChallengeFragment>.of(data.spiceChallenges))
        .map((rows) => rows.firstOrNull);
  }

  /// Records that the person is an adult; the server refuses to switch the mode on without it.
  Future<void> grantAdultConsent(String version) async {
    final response = await _client.mutate(
      OptionsMutationGrantAdultConsent(
        variables: VariablesMutationGrantAdultConsent(version: version),
      ),
    );

    validateResponse(response);
  }

  Future<void> setEnabled({required String userId, required bool enabled}) async {
    final response = await _client.mutate(
      OptionsMutationSetSpiceEnabled(
        variables: VariablesMutationSetSpiceEnabled(userId: userId, enabled: enabled),
      ),
    );

    validateResponse(response);
  }

  /// Switches the mode off for both people and removes what it kept.
  Future<void> turnOff() async {
    final response = await _client.mutate(OptionsMutationSpiceOff());

    validateResponse(response);
  }

  /// The open card, or a new one; null when there is none left.
  Future<MutationSpiceNextCardspiceNextCard?> nextCard() async {
    final response = await _client.mutate(OptionsMutationSpiceNextCard());
    final rows = validateResponseData(response, getData: (data) => data.spiceNextCard);

    return rows.firstOrNull;
  }

  Future<void> respondToCard({required String playId, required bool accept}) async {
    final response = await _client.mutate(
      OptionsMutationSpiceRespondCard(
        variables: VariablesMutationSpiceRespondCard(playId: playId, accept: accept),
      ),
    );

    validateResponse(response);
  }

  Future<Map<String, String>> getTexts({
    required List<String> slugs,
    required String locale,
  }) async {
    if (slugs.isEmpty) return const {};
    final response = await _client.query(
      OptionsQuerySpiceTexts(
        variables: VariablesQuerySpiceTexts(slugs: slugs, locale: locale),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final items = validateResponseData(response, getData: (data) => data.contentItems);

    return {for (final item in items) item.slug: item.title};
  }

  Future<List<QuerySpiceDesirescontentItems>> getDesires({
    required String locale,
    required int maxLevel,
  }) async {
    final response = await _client.query(
      OptionsQuerySpiceDesires(
        variables: VariablesQuerySpiceDesires(locale: locale, maxLevel: maxLevel),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return validateResponseData(response, getData: (data) => data.contentItems);
  }

  Future<List<QueryMySpiceAnswersspiceDesireAnswers>> getAnswers() async {
    final response = await _client.query(
      OptionsQueryMySpiceAnswers(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response, getData: (data) => data.spiceDesireAnswers);
  }

  Future<void> answerDesire({required String slug, required EnumSpiceAnswer_enum answer}) async {
    final response = await _client.mutate(
      OptionsMutationAnswerSpiceDesire(
        variables: VariablesMutationAnswerSpiceDesire(slug: slug, answer: answer),
      ),
    );

    validateResponse(response);
  }

  Future<List<QuerySpiceMatchesspiceMatches>> getMatches() async {
    final response = await _client.query(
      OptionsQuerySpiceMatches(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response, getData: (data) => data.spiceMatches);
  }

  Future<FragmentSpiceChallengeFragment?> getChallenge() async {
    final response = await _client.mutate(OptionsMutationSpiceChallenge());
    final rows = validateResponseData(response, getData: (data) => data.spiceChallenge);

    return rows.firstOrNull;
  }

  Future<FragmentSpiceChallengeFragment?> actOnChallenge(String action) async {
    final response = await _client.mutate(
      OptionsMutationSpiceChallengeAct(
        variables: VariablesMutationSpiceChallengeAct(action: action),
      ),
    );
    final rows = validateResponseData(response, getData: (data) => data.spiceChallengeAct);

    return rows.firstOrNull;
  }

  Future<QueryMySpiceSettingsuserSettingsByPk> getSettings(String userId) async {
    final response = await _client.query(
      OptionsQueryMySpiceSettings(
        variables: VariablesQueryMySpiceSettings(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return validateResponseData(response, getData: (data) => data.userSettingsByPk);
  }

  Future<void> setSettings({
    required String userId,
    required int level,
    required bool notifications,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSetSpiceSettings(
        variables: VariablesMutationSetSpiceSettings(
          userId: userId,
          level: level,
          notifications: notifications,
        ),
      ),
    );

    validateResponse(response);
  }
}
