import 'package:app/features/history/data/data_sources/remote/queries/generated/HistoryOverview.graphql.dart';
import 'package:app/features/history/data/mappers/history_mapper.dart';
import 'package:app/features/history/data/models/history_models.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:flutter_test/flutter_test.dart';

final _now = DateTime(2026, 11, 9);

Object? _typed(Object? value) {
  if (value is Map<String, dynamic>) {
    return {for (final entry in value.entries) entry.key: _typed(entry.value), '__typename': 'T'};
  }
  if (value is List) return [for (final item in value) _typed(item)];
  return value;
}

Map<String, dynamic> _profile({
  required String id,
  String? displayName,
  String avatarKind = 'initials',
}) => {'id': id, 'displayName': displayName, 'avatarFileId': null, 'avatarKind': avatarKind};

Map<String, dynamic> _couple({String id = 'c1', List<Map<String, dynamic>> members = const []}) => {
  'id': id,
  'members': members,
};

Map<String, dynamic> _member({
  String userId = 'u1',
  String coupleId = 'c1',
  Map<String, dynamic>? profile,
  Map<String, dynamic>? couple,
}) => {
  'coupleId': coupleId,
  'couple': couple ?? _couple(),
  'userId': userId,
  'profile': profile ?? _profile(id: userId),
};

Map<String, dynamic> _story({
  required String id,
  String authorId = 'u1',
  String? coupleId = 'c1',
  String kind = 'custom',
  String? title,
  String? happenedOn,
}) => {
  'id': id,
  'authorId': authorId,
  'coupleId': coupleId,
  'kind': kind,
  'title': title,
  'happenedOn': happenedOn,
  'datePrecision': 'day',
};

Map<String, dynamic> _memory({
  required String id,
  String authorId = 'u1',
  String title = 'Memória',
  String? place,
  String origin = 'manual',
  String? happenedOn,
}) => {
  'id': id,
  'authorId': authorId,
  'coupleId': 'c1',
  'title': title,
  'body': null,
  'happenedOn': happenedOn,
  'datePrecision': 'day',
  'place': place,
  'photoFileId': null,
  'origin': origin,
};

Map<String, dynamic> _date({
  required String id,
  required String kind,
  String authorId = 'u1',
  String title = 'Data',
  int month = 11,
  int day = 20,
  int? year,
  bool hidden = false,
}) => {
  'id': id,
  'authorId': authorId,
  'coupleId': 'c1',
  'title': title,
  'kind': kind,
  'month': month,
  'day': day,
  'year': year,
  'yearly': false,
  'hidden': hidden,
};

QueryHistoryOverview _overview({
  Map<String, dynamic>? profile,
  Map<String, dynamic>? member,
  Map<String, dynamic>? settings,
  List<Map<String, dynamic>> stories = const [],
  List<Map<String, dynamic>> memories = const [],
  List<Map<String, dynamic>> dates = const [],
  Map<String, dynamic>? year,
}) => QueryHistoryOverview.fromJson(
  _typed({
        'profile': profile,
        'member': member,
        'settings': settings,
        'storyEvents': stories,
        'memories': memories,
        'importantDates': dates,
        'yearRecaps': year == null ? <Map<String, dynamic>>[] : [year],
      })!
      as Map<String, dynamic>,
);

void main() {
  test('someone alone with no history gets an empty, unpaired overview', () {
    final overview = _overview().toModel(now: _now);

    expect(overview.isPaired, isFalse);
    expect(overview.coupleId, isNull);
    expect(overview.partnerName, isNull);
    expect(overview.selfInitials, 'V');
    expect(overview.partnerInitials, isNull);
    expect(overview.avatarKind, AvatarKind.initials);
    expect(overview.phase, RelationshipPhase.dating);
    expect(overview.milestones, isEmpty);
    expect(overview.togetherSince, isNull);
    expect(overview.memoryCount, 0);
  });

  test('a couple gets names, initials and the couple id', () {
    final overview = _overview(
      profile: _profile(id: 'u1', displayName: '  ana '),
      member: _member(
        couple: _couple(
          members: [
            _member(userId: 'u1', couple: _couple()),
            _member(
              userId: 'u2',
              profile: _profile(id: 'u2', displayName: 'Bia'),
            ),
          ],
        ),
      ),
    ).toModel(now: _now);

    expect(overview.isPaired, isTrue);
    expect(overview.coupleId, 'c1');
    expect(overview.selfId, 'u1');
    expect(overview.selfName, 'ana');
    expect(overview.selfInitials, 'A');
    expect(overview.partnerName, 'Bia');
    expect(overview.partnerInitials, 'B');
  });

  test('a couple whose partner profile is unreadable keeps the partner unnamed', () {
    final overview = _overview(
      profile: _profile(id: 'u1', displayName: 'ana'),
      member: _member(
        couple: _couple(
          members: [
            _member(userId: 'u1', couple: _couple()),
            _member(userId: 'u2', couple: _couple()),
          ],
        ),
      ),
    ).toModel(now: _now);

    expect(overview.isPaired, isTrue);
    expect(overview.partnerName, isNull);
    expect(overview.partnerInitials, isNull);
  });

  test('the partner name falls back to the one the person typed in settings', () {
    final overview = _overview(
      settings: {
        'userId': 'u1',
        'phase': null,
        'togetherSince': null,
        'partnerName': 'Caio',
        'relationshipStatus': 'together',
      },
    ).toModel(now: _now);

    expect(overview.partnerName, 'Caio');
    expect(overview.selfId, 'u1');
  });

  test('story events become milestones with the default title when none was written', () {
    final overview = _overview(
      profile: _profile(id: 'u1'),
      stories: [
        _story(id: 's1', kind: 'met', happenedOn: '2024-03-14'),
        _story(id: 's2', title: '  Mudança  ', happenedOn: '2025-01-10'),
      ],
    ).toModel(now: _now);

    expect(overview.milestones.map((milestone) => milestone.title), ['Nos conhecemos', 'Mudança']);
    expect(overview.milestones.first.kind, MilestoneKind.met);
    expect(overview.milestones.first.source, MilestoneSource.storyEvent);
  });

  test('a partner milestone shows who wrote it, and mine does not', () {
    final overview = _overview(
      profile: _profile(id: 'u1'),
      member: _member(
        couple: _couple(
          members: [
            _member(userId: 'u1', couple: _couple()),
            _member(
              userId: 'u2',
              profile: _profile(id: 'u2', displayName: 'Bia'),
            ),
          ],
        ),
      ),
      stories: [
        _story(id: 'mine', happenedOn: '2024-01-01'),
        _story(id: 'theirs', authorId: 'u2', happenedOn: '2024-02-01'),
      ],
    ).toModel(now: _now);

    expect(overview.milestones.first.authorName, isNull);
    expect(overview.milestones.last.authorName, 'Bia');
  });

  test('a memory with a place reads as a trip and counts as a place', () {
    final overview = _overview(
      profile: _profile(id: 'u1'),
      memories: [_memory(id: 'm1', place: ' Paraty ', happenedOn: '2025-07-01')],
    ).toModel(now: _now);

    final milestone = overview.milestones.single;
    expect(milestone.kind, MilestoneKind.trip);
    expect(milestone.place, 'Paraty');
    expect(milestone.source, MilestoneSource.memory);
    expect(overview.memoryCount, 1);
  });

  test('hidden dates, birthdays and holidays stay off the timeline', () {
    final overview = _overview(
      profile: _profile(id: 'u1'),
      dates: [
        _date(id: 'd1', kind: 'trip', title: 'Viagem', year: 2025),
        _date(id: 'd2', kind: 'birthday'),
        _date(id: 'd3', kind: 'holiday'),
        _date(id: 'd4', kind: 'first', hidden: true),
      ],
    ).toModel(now: _now);

    expect(overview.milestones.map((milestone) => milestone.id), ['d1']);
    expect(overview.milestones.single.precision, MilestoneDatePrecision.day);
  });

  test('a date without a year has an unknown date and precision', () {
    final overview = _overview(
      profile: _profile(id: 'u1'),
      dates: [_date(id: 'd1', kind: 'custom')],
    ).toModel(now: _now);

    expect(overview.milestones.single.date, isNull);
    expect(overview.milestones.single.precision, MilestoneDatePrecision.unknown);
  });

  test('the next reunion is the nearest one that is not in the past', () {
    final overview = _overview(
      profile: _profile(id: 'u1'),
      dates: [
        _date(id: 'past', kind: 'reunion', month: 10, day: 1, year: 2026),
        _date(id: 'far', kind: 'reunion', month: 12, day: 24, year: 2026),
        _date(id: 'near', kind: 'reunion', month: 11, day: 20, year: 2026),
      ],
    ).toModel(now: _now);

    expect(overview.nextReunionDate, DateTime.utc(2026, 11, 20));
  });

  test('milestones are ordered by date, and the ones without a date go last', () {
    final overview = _overview(
      profile: _profile(id: 'u1'),
      stories: [_story(id: 'late', happenedOn: '2025-05-01')],
      memories: [_memory(id: 'early', happenedOn: '2023-05-01')],
      dates: [_date(id: 'undated', kind: 'custom')],
    ).toModel(now: _now);

    expect(overview.milestones.map((milestone) => milestone.id), ['early', 'late', 'undated']);
  });

  test('together since comes from settings first, then the dating and met events', () {
    final fromEvents = _overview(
      profile: _profile(id: 'u1'),
      stories: [
        _story(id: 'met', kind: 'met', happenedOn: '2024-01-01'),
        _story(id: 'dating', kind: 'dating', happenedOn: '2024-03-14'),
      ],
    ).toModel(now: _now);
    final fromSettings = _overview(
      profile: _profile(id: 'u1'),
      settings: {
        'userId': 'u1',
        'phase': 'married',
        'togetherSince': '2020-06-01',
        'partnerName': null,
        'relationshipStatus': 'together',
      },
      stories: [_story(id: 'dating', kind: 'dating', happenedOn: '2024-03-14')],
    ).toModel(now: _now);

    expect(fromEvents.togetherSince, DateTime(2024, 3, 14));
    expect(fromSettings.togetherSince, DateTime(2020, 6));
    expect(fromSettings.phase, RelationshipPhase.married);
  });

  test('more history is flagged when a list has another page', () {
    final overview = _overview(
      profile: _profile(id: 'u1'),
      memories: [
        for (var index = 0; index < 51; index++) _memory(id: 'm$index', happenedOn: '2025-07-01'),
      ],
    ).toModel(now: _now);

    expect(overview.memoryCount, 50);
    expect(overview.hasMoreMemories, isTrue);
    expect(overview.hasMoreHistory, isTrue);
  });

  test('the year recap fills in zero for a count the server left out', () {
    final overview = _overview(
      profile: _profile(id: 'u1'),
      year: {
        'year': 2026,
        'slips': 12,
        'cardsSent': null,
        'cardsReceived': null,
        'memories': 3,
        'firsts': null,
        'ritualsDone': null,
      },
    ).toModel(now: _now);

    expect(overview.numbers.yearRecap?.year, 2026);
    expect(overview.numbers.yearRecap?.slips, 12);
    expect(overview.numbers.yearRecap?.cardsSent, 0);
    expect(overview.numbers.yearRecap?.memories, 3);
  });
}
