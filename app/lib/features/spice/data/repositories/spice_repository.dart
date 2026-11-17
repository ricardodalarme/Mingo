import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/spice/data/data_sources/remote/fragments/generated/SpiceChallengeFragment.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/spice_data_source.dart';
import 'package:app/features/spice/data/mappers/spice_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

/// The version of the adult declaration the person accepts.
const String adultConsentVersion = '1';

class SpiceRepository({
  required final SpiceDataSource _dataSource,
  required final ProfileRepository _profileRepository,
  required final AuthenticationRepository _authenticationRepository,
}) {
  final Logger _logger = Logger('SpiceRepository');

  String get _userId {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) throw const LocalizedException(l10nKey: 'UNAUTHENTICATED');

    return userId;
  }

  Future<String> _locale() async => (await _profileRepository.getMySettings()).locale;

  Future<SpiceStatus> getStatus() => _run('read the mode', () async {
    final node = await _dataSource.getState();

    return _status((state: node.state, myLevel: node.myLevel, coupleLevel: node.coupleLevel));
  });

  /// Emits the mode now and each time either person changes it. A failed event is logged and
  /// skipped, so a screen keeps what it shows.
  Stream<SpiceStatus> watchStatus() {
    return _dataSource.watchState().map(_status).handleError((Object e, StackTrace stack) {
      _logger.error('The mode subscription failed', error: e, stackTrace: stack);
    });
  }

  /// Emits the couple's challenge now and each time the partner or the person acts on it; null
  /// when there is none. A failed event is logged and skipped.
  Stream<SpiceChallenge?> watchChallenge() {
    return _dataSource.watchChallenge().asyncMap(_toChallenge).handleError((
      Object e,
      StackTrace stack,
    ) {
      _logger.error('The challenge subscription failed', error: e, stackTrace: stack);
    });
  }

  SpiceStatus _status(SpiceStateRecord node) => SpiceStatus(
    stage: spiceStageFromRemote(node.state),
    myLevel: spiceLevelFromRemote(node.myLevel),
    coupleLevel: node.coupleLevel == null ? null : spiceLevelFromRemote(node.coupleLevel),
  );

  /// Confirms the person is an adult and switches the mode on for them only.
  Future<void> turnOn() => _run('switch the mode on', () async {
    await _dataSource.grantAdultConsent(adultConsentVersion);
    await _dataSource.setEnabled(userId: _userId, enabled: true);
  });

  /// Switches the mode off for both people; what it kept is removed.
  Future<void> turnOff() => _run('switch the mode off', _dataSource.turnOff);

  /// The open evening card, or a new one; null when the cards are used up.
  Future<SpiceCard?> getNextCard() => _run('read the next card', () async {
    final node = await _dataSource.nextCard();
    if (node == null) return null;
    final texts = await _dataSource.getTexts(slugs: [node.contentSlug], locale: await _locale());

    return SpiceCard(
      id: node.id,
      text: texts[node.contentSlug] ?? '',
      isMine: node.proposedBy == _userId,
    );
  });

  Future<void> respondToCard({required String id, required bool accept}) =>
      _run('answer a card', () => _dataSource.respondToCard(playId: id, accept: accept));

  /// The desires up to the couple's level, each with the person's own answer.
  Future<List<SpiceDesire>> getDesires(SpiceLevel maxLevel) => _run('read the desires', () async {
    final (desires, answers) = await (
      _locale().then(
        (locale) => _dataSource.getDesires(locale: locale, maxLevel: maxLevel.toRemote()),
      ),
      _dataSource.getAnswers(),
    ).wait;
    final byId = {for (final answer in answers) answer.contentSlug: answer.answer.toModel()};

    return [
      for (final node in desires)
        SpiceDesire(
          slug: node.slug,
          title: node.title,
          level: spiceLevelFromRemote(node.level),
          answer: byId[node.slug],
        ),
    ];
  });

  Future<void> answerDesire({required String slug, required SpiceAnswer answer}) => _run(
    'answer a desire',
    () => _dataSource.answerDesire(slug: slug, answer: answer.toRemote()),
  );

  Future<List<SpiceMatch>> getMatches() => _run('read the matches', () async {
    return [
      for (final node in await _dataSource.getMatches())
        SpiceMatch(slug: node.slug, title: node.title),
    ];
  });

  Future<SpiceChallenge?> getChallenge() =>
      _run('read the challenge', () async => _toChallenge(await _dataSource.getChallenge()));

  Future<SpiceChallenge?> actOnChallenge(SpiceChallengeAction action) => _run(
    'act on the challenge',
    () async => _toChallenge(await _dataSource.actOnChallenge(action.name)),
  );

  Future<SpiceSettings> getSettings() => _run('read the settings', () async {
    final node = await _dataSource.getSettings(_userId);

    return SpiceSettings(
      maxLevel: spiceLevelFromRemote(node.spiceMaxLevel),
      notifications: node.spiceNotifications,
    );
  });

  Future<void> setSettings(SpiceSettings settings) => _run(
    'save the settings',
    () => _dataSource.setSettings(
      userId: _userId,
      level: settings.maxLevel.toRemote(),
      notifications: settings.notifications,
    ),
  );

  Future<SpiceChallenge?> _toChallenge(FragmentSpiceChallengeFragment? node) async {
    if (node == null) return null;
    final texts = await _dataSource.getTexts(slugs: [node.contentSlug], locale: await _locale());
    final me = _userId;
    final partnerAccepted = node.acceptedBy.any((id) => id != me);

    return SpiceChallenge(
      text: texts[node.contentSlug] ?? '',
      acceptedByMe: node.acceptedBy.contains(me),
      doneByMe: node.doneBy.contains(me),
      acceptedByPartner: partnerAccepted,
      swapsLeft: spiceMaxSwaps - node.swaps,
    );
  }

  Future<T> _run<T>(String what, Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, stack) {
      _logger.error('Failed to $what', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
