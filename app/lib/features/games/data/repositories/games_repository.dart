import 'package:app/features/_shared/data/mappers/content_kind_mapper.dart';
import 'package:app/features/games/data/data_sources/remote/games_data_source.dart';
import 'package:app/features/games/data/mappers/game_enum_mapper.dart';
import 'package:app/features/games/data/mappers/game_item_mapper.dart';
import 'package:app/features/games/data/mappers/game_session_mapper.dart';
import 'package:app/features/games/data/mappers/games_overview_mapper.dart';
import 'package:app/features/games/data/models/game_item.dart';
import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:app/features/games/data/models/games_overview.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';
import 'package:network/network.dart';

/// The code the server raises when finishing before both people answered every item.
const String gameNotCompleteCode = 'GAME_NOT_COMPLETE';

/// The code the server raises when an answer can no longer change.
const String gameAnswerLockedCode = 'ANSWER_LOCKED';

class GamesRepository({required final GamesDataSource _dataSource}) {
  final Logger _logger = Logger('GamesRepository');

  /// The couple's games with their latest sessions; no answers are read.
  Future<GamesOverview> getOverview() async {
    final record = await _dataSource.getSessions();

    return record.toModel();
  }

  /// Emits the couple's sessions now and each time one is created or changes.
  ///
  /// A failed event is logged and skipped, so a screen keeps what it shows.
  Stream<List<GameSession>> watchSessions() {
    return _dataSource
        .watchSessions()
        .map((records) => [for (final record in records) ?record.toModel()])
        .handleError((Object e, StackTrace stack) {
          _logger.error('The game sessions subscription failed', error: e, stackTrace: stack);
        });
  }

  /// One game with its latest session, items and the answers the server lets this person see.
  ///
  /// When there is no session, the items a new one could start with are read instead. A
  /// cancelled or expired session is kept so the start screen can explain what happened. A
  /// game without published content comes back with no items.
  Future<GamePlay> getPlay({required GameKind kind, required String locale, DateTime? now}) async {
    final record = await _dataSource.getSessions();
    final overview = record.toModel();
    if (!record.hasCouple) {
      return GamePlay(kind: kind, selfId: record.selfId, hasPartner: false);
    }

    final session = overview.latestFor(kind);
    final isOpen = session != null && session.isOpen(now ?? clock.now());
    final isFinished = session?.status == GameStatus.finished;
    final available = isOpen ? const <GameItem>[] : await _available(kind, locale);
    if (session == null) {
      return GamePlay(
        kind: kind,
        selfId: record.selfId,
        partnerName: record.partnerName,
        available: available,
      );
    }
    if (!isOpen && !isFinished) {
      return GamePlay(
        kind: kind,
        selfId: record.selfId,
        partnerName: record.partnerName,
        session: session,
        available: available,
      );
    }

    final items = await _items(kind, locale, session.itemSlugs);
    final answers = session.status == GameStatus.invited
        ? const <GameAnswerRecord>[]
        : await _dataSource.getAnswers(sessionId: session.id, selfId: record.selfId);

    return GamePlay(
      kind: kind,
      selfId: record.selfId,
      partnerName: record.partnerName,
      session: session,
      items: items,
      available: available,
      own: {
        for (final row in answers)
          if (row.isMine) row.idx: row.answer,
      },
      partner: {
        for (final row in answers)
          if (!row.isMine) row.idx: row.answer,
      },
    );
  }

  /// Starts a session of [kind] with the next questions the content offers.
  ///
  /// The server serves unseen questions first and recycles the oldest ones when the
  /// pool runs out, so a replay does not repeat the same round.
  Future<GameSession> invite(GameKind kind) async {
    final items = await _dataSource.nextItems(game: kind.key, count: kind.itemCount);
    final slugs = [for (final item in items) item.slug];
    if (slugs.isEmpty) throw const NoDataException();
    final record = await _dataSource.invite(
      game: kind.toRemote(),
      itemSlugs: kind.asksTwice ? [...slugs, ...slugs] : slugs,
    );

    return record.toModel()!;
  }

  Future<GameSession> join(GameSession session) => _update(session, 'join');

  Future<GameSession> cancel(GameSession session) => _update(session, 'cancel');

  /// Saves one answer; answering the same [step] again replaces it.
  Future<void> answer({required GameSession session, required int step, required String answer}) =>
      _dataSource.answer(sessionId: session.id, idx: step, answer: answer.trim());

  /// Finishes the session when both people answered every item, or returns null when the
  /// partner is still answering.
  Future<GameSession?> finishIfComplete(GameSession session) async {
    try {
      final record = await _dataSource.update(sessionId: session.id, action: 'finish');

      return record.toModel();
    } on LocalizedException catch (exception) {
      if (exception.l10nKey == gameNotCompleteCode) return null;
      rethrow;
    }
  }

  Future<GameSession> _update(GameSession session, String action) async {
    final record = await _dataSource.update(sessionId: session.id, action: action);

    return record.toModel()!;
  }

  Future<List<GameItem>> _available(GameKind kind, String locale) async {
    final contentKind = kind.contentKind;
    if (contentKind == null) return const [];
    final records = await _dataSource.getItems(
      kind: contentKind.toRemote(),
      locale: locale,
      limit: kind.itemCount,
    );

    return [for (final record in records) record.toModel()];
  }

  Future<List<GameItem>> _items(GameKind kind, String locale, List<String> slugs) async {
    final contentKind = kind.contentKind;
    if (contentKind == null || slugs.isEmpty) return const [];
    final records = await _dataSource.getItemsBySlug(
      kind: contentKind.toRemote(),
      locale: locale,
      slugs: slugs.toSet().toList(),
    );
    final bySlug = {for (final record in records) record.slug: record.toModel()};

    return [for (final slug in slugs) ?bySlug[slug]];
  }
}
