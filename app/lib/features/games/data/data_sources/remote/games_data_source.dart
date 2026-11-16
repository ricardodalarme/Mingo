import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/fragments/generated/GameSessionFragment.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/mutations/generated/AnswerGame.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/mutations/generated/InviteToGame.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/mutations/generated/UpdateGame.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/queries/generated/GameAnswers.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/queries/generated/GameItems.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/queries/generated/GameItemsBySlug.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/queries/generated/GameSessions.graphql.dart';
import 'package:network/network.dart';

typedef GameSessionRecord = ({
  String id,
  EnumGameKind_enum game,
  EnumGameStatus_enum status,
  String invitedBy,
  List<String> itemSlugs,
  DateTime createdAt,
});

/// The person, the partner and the latest sessions of the couple.
typedef GameSessionsRecord = ({
  String selfId,
  bool hasCouple,
  String? partnerName,
  List<GameSessionRecord> sessions,
});

typedef GameItemRecord = ({String slug, String title, String? body});

typedef GameAnswerRecord = ({bool isMine, int idx, String answer});

class GamesDataSource({required final GQLClient _client}) {
  Future<GameSessionsRecord> getSessions() async {
    final response = await _client.query(
      OptionsQueryGameSessions(fetchPolicy: FetchPolicy.networkOnly),
    );
    final data = validateResponseData<QueryGameSessions, QueryGameSessions>(response);
    final today = data.today.firstOrNull;
    final selfId = today?.userId;
    if (today == null || selfId == null) throw const NoDataException();

    return (
      selfId: selfId,
      hasCouple: today.coupleId != null,
      partnerName: today.partnerName,
      sessions: [for (final node in data.gameSessions) _session(node)],
    );
  }

  /// The published items of a content [kind] for [locale], in editorial order.
  Future<List<GameItemRecord>> getItems({
    required EnumContentKind_enum kind,
    required String locale,
    required int limit,
  }) async {
    final response = await _client.query(
      OptionsQueryGameItems(
        variables: VariablesQueryGameItems(kind: kind, locale: locale, limit: limit),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final rows = validateResponseData(response, getData: (data) => data.contentItems);

    return [for (final row in rows) (slug: row.slug, title: row.title, body: row.body)];
  }

  Future<List<GameItemRecord>> getItemsBySlug({
    required EnumContentKind_enum kind,
    required String locale,
    required List<String> slugs,
  }) async {
    final response = await _client.query(
      OptionsQueryGameItemsBySlug(
        variables: VariablesQueryGameItemsBySlug(kind: kind, locale: locale, slugs: slugs),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final rows = validateResponseData(response, getData: (data) => data.contentItems);

    return [for (final row in rows) (slug: row.slug, title: row.title, body: row.body)];
  }

  /// The answer rows the server lets this person read.
  Future<List<GameAnswerRecord>> getAnswers({
    required String sessionId,
    required String selfId,
  }) async {
    final response = await _client.query(
      OptionsQueryGameAnswers(
        variables: VariablesQueryGameAnswers(sessionId: sessionId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final rows = validateResponseData(response, getData: (data) => data.gameAnswers);

    return [
      for (final row in rows) (isMine: row.authorId == selfId, idx: row.idx, answer: row.answer),
    ];
  }

  Future<GameSessionRecord> invite({
    required EnumGameKind_enum game,
    required List<String> itemSlugs,
  }) async {
    final response = await _client.mutate(
      OptionsMutationInviteToGame(
        variables: VariablesMutationInviteToGame(game: game, itemSlugs: itemSlugs),
      ),
    );
    final node = validateResponseData(response, getData: (data) => data.insertGameSessionsOne);

    return _session(node);
  }

  /// Joins, cancels or finishes a session with a server [action].
  Future<GameSessionRecord> update({
    required String sessionId,
    required String action,
    String? outcome,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateGame(
        variables: VariablesMutationUpdateGame(
          sessionId: sessionId,
          action: action,
          outcome: outcome,
        ),
      ),
    );
    final node = validateResponseData(response, getData: (data) => data.updateGame.firstOrNull);

    return _session(node);
  }

  Future<void> answer({required String sessionId, required int idx, required String answer}) async {
    final response = await _client.mutate(
      OptionsMutationAnswerGame(
        variables: VariablesMutationAnswerGame(sessionId: sessionId, idx: idx, answer: answer),
      ),
    );

    validateResponse(response);
  }

  GameSessionRecord _session(FragmentGameSessionFragment node) => (
    id: node.id,
    game: node.game,
    status: node.status,
    invitedBy: node.invitedBy,
    itemSlugs: node.itemSlugs.whereType<String>().toList(),
    createdAt: node.createdAt,
  );
}
