import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/history/data/data_sources/remote/history_data_source.dart';
import 'package:app/features/history/data/data_sources/remote/queries/generated/HistoryOverview.graphql.dart';
import 'package:app/features/history/data/models/history_models.dart';
import 'package:app/features/history/data/models/story_event_kind.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:app/features/profile/data/models/relationship_status.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockHistoryDataSource() extends Mock implements HistoryDataSource;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late HistoryDataSource dataSource;
  late AuthenticationRepository authenticationRepository;
  late HistoryRepository repository;

  setUpAll(() {
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(EnumRelationshipPhase_enum.dating);
  });

  setUp(() {
    dataSource = _MockHistoryDataSource();
    authenticationRepository = _MockAuthenticationRepository();
    when(() => authenticationRepository.currentUserId).thenReturn('self-1');
    repository = HistoryRepository(
      dataSource: dataSource,
      authenticationRepository: authenticationRepository,
    );
  });

  test('getOverview maps story events, memories, unknown-year dates, and year recap', () async {
    when(
      () => dataSource.getOverview(
        userId: any(named: 'userId'),
        year: any(named: 'year'),
      ),
    ).thenAnswer(
      (_) async => QueryHistoryOverview(
        profile: QueryHistoryOverviewprofile(
          id: 'self-1',
          displayName: 'Rafa',
          avatarKind: EnumAvatarKind_enum.initials,
        ),
        member: QueryHistoryOverviewmember(
          couple: QueryHistoryOverviewmembercouple(
            id: 'couple-1',
            members: [
              QueryHistoryOverviewmembercouplemembers(
                userId: 'self-1',
                profile: QueryHistoryOverviewmembercouplemembersprofile(
                  id: 'self-1',
                  displayName: 'Rafa',
                  avatarKind: EnumAvatarKind_enum.initials,
                ),
              ),
              QueryHistoryOverviewmembercouplemembers(
                userId: 'partner-1',
                profile: QueryHistoryOverviewmembercouplemembersprofile(
                  id: 'partner-1',
                  displayName: 'Marina',
                  avatarKind: EnumAvatarKind_enum.photo,
                ),
              ),
            ],
          ),
        ),
        settings: QueryHistoryOverviewsettings(
          userId: 'self-1',
          phase: EnumRelationshipPhase_enum.dating,
          togetherSince: DateTime(2024, 3, 14),
          partnerName: 'Marina',
          relationshipStatus: EnumRelationshipStatus_enum.together,
        ),
        storyEvents: [
          QueryHistoryOverviewstoryEvents(
            id: 'se-1',
            authorId: 'self-1',
            kind: EnumStoryEventKind_enum.met,
            title: 'Nos conhecemos',
            happenedOn: DateTime(2024, 3, 14),
            datePrecision: EnumDatePrecision_enum.day,
          ),
          QueryHistoryOverviewstoryEvents(
            id: 'se-2',
            authorId: 'partner-1',
            kind: EnumStoryEventKind_enum.dating,
            title: 'Começamos a namorar',
            happenedOn: DateTime(2024, 3, 22),
            datePrecision: EnumDatePrecision_enum.day,
          ),
        ],
        memories: [
          QueryHistoryOverviewmemories(
            id: 'mem-1',
            authorId: 'self-1',
            title: 'Primeira viagem juntos',
            happenedOn: DateTime(2025, 7, 1),
            datePrecision: EnumDatePrecision_enum.month,
            place: 'Paraty',
            origin: EnumMemoryOrigin_enum.manual,
          ),
        ],
        importantDates: [
          QueryHistoryOverviewimportantDates(
            id: 'id-1',
            authorId: 'self-1',
            title: 'Primeiro olhar',
            kind: EnumImportantDateKind_enum.first,
            month: 1,
            day: 1,
            yearly: false,
            hidden: false,
          ),
        ],
        yearRecaps: [
          QueryHistoryOverviewyearRecaps(
            year: 2026,
            memories: 4,
            firsts: 2,
            slips: 10,
            cardsSent: 3,
            cardsReceived: 3,
            ritualsDone: 5,
          ),
        ],
      ),
    );

    final overview = await repository.getOverview(now: DateTime(2026, 11, 8));

    expect(overview.selfInitials, 'R');
    expect(overview.partnerInitials, 'M');
    expect(overview.milestones, hasLength(4));
    expect(overview.hasUnknownYearMilestones, isTrue);
    expect(overview.numbers.places, ['Paraty']);
    expect(overview.storyDates.hasDifferentStartDates, isTrue);
    expect(overview.storyDates.met.isMine, isTrue);
    expect(overview.storyDates.dating.isMine, isFalse);
    expect(overview.storyDates.dating.authorName, 'Marina');
    expect(overview.relationshipStatus, RelationshipStatus.together);
    expect(overview.memoryCount, 1);
    expect(overview.hasMoreHistory, isFalse);
  });

  test('refuses to edit or delete a partner-owned milestone', () async {
    const partnerMilestone = HistoryMilestone(
      id: 'partner-memory',
      source: MilestoneSource.memory,
      kind: MilestoneKind.trip,
      title: 'Viagem dela',
      isMine: false,
    );

    await expectLater(
      repository.deleteMilestone(partnerMilestone),
      throwsA(isA<LocalizedException>()),
    );
    await expectLater(
      repository.saveMilestone(
        id: 'partner-memory',
        title: 'Viagem dela',
        kind: MilestoneKind.trip,
        precision: MilestoneDatePrecision.day,
        isShared: true,
        date: DateTime(2025, 7, 15),
        existing: partnerMilestone,
      ),
      throwsA(isA<LocalizedException>()),
    );
    await expectLater(
      repository.saveStoryDate(
        id: 'new-event',
        profileId: 'self-1',
        kind: StoryEventKind.dating,
        title: 'Começamos a namorar',
        date: DateTime(2024, 3, 22),
        existingEventId: 'partner-event',
        existingEventIsMine: false,
      ),
      throwsA(isA<LocalizedException>()),
    );

    verifyNever(() => dataSource.deleteMemory(any()));
    verifyNever(
      () => dataSource.updateStoryEvent(
        id: any(named: 'id'),
        kind: any(named: 'kind'),
        happenedOn: any(named: 'happenedOn'),
        datePrecision: any(named: 'datePrecision'),
        title: any(named: 'title'),
        coupleId: any(named: 'coupleId'),
      ),
    );
  });

  test('updates a memory in place', () async {
    when(
      () => dataSource.updateMemory(
        id: any(named: 'id'),
        coupleId: any(named: 'coupleId'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        place: any(named: 'place'),
        happenedOn: any(named: 'happenedOn'),
        datePrecision: any(named: 'datePrecision'),
      ),
    ).thenAnswer((_) async {
      return;
    });

    const existing = HistoryMilestone(
      id: 'mem-1',
      source: MilestoneSource.memory,
      kind: MilestoneKind.custom,
      title: 'Primeira vez',
      isMine: true,
    );

    await repository.saveMilestone(
      id: 'mem-1',
      title: 'Primeira vez',
      kind: MilestoneKind.first,
      precision: MilestoneDatePrecision.month,
      isShared: true,
      date: DateTime(2025, 7, 15),
      body: 'Guardado',
      coupleId: 'couple-1',
      existing: existing,
    );

    verify(
      () => dataSource.updateMemory(
        id: 'mem-1',
        coupleId: 'couple-1',
        title: 'Primeira vez',
        body: 'Guardado',
        place: null,
        happenedOn: DateTime.utc(2025, 7, 1),
        datePrecision: EnumDatePrecision_enum.month,
      ),
    ).called(1);
  });

  test('converts a story event into a memory before deleting the old row', () async {
    when(
      () => dataSource.insertMemory(
        id: any(named: 'id'),
        coupleId: any(named: 'coupleId'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        place: any(named: 'place'),
        happenedOn: any(named: 'happenedOn'),
        datePrecision: any(named: 'datePrecision'),
        origin: any(named: 'origin'),
      ),
    ).thenAnswer((_) async {
      return;
    });
    when(() => dataSource.deleteStoryEvent(any())).thenAnswer((_) async {
      return;
    });

    const existing = HistoryMilestone(
      id: 'se-1',
      source: MilestoneSource.storyEvent,
      kind: MilestoneKind.met,
      title: 'Nos conhecemos',
      isMine: true,
    );

    await repository.saveMilestone(
      id: 'se-1',
      title: 'Nos conhecemos em Paraty',
      kind: MilestoneKind.trip,
      precision: MilestoneDatePrecision.month,
      isShared: true,
      date: DateTime(2024, 3, 14),
      place: 'Paraty',
      coupleId: 'couple-1',
      existing: existing,
    );

    verifyInOrder([
      () => dataSource.insertMemory(
        id: 'se-1',
        coupleId: 'couple-1',
        title: 'Nos conhecemos em Paraty',
        body: null,
        place: 'Paraty',
        happenedOn: DateTime.utc(2024, 3, 1),
        datePrecision: EnumDatePrecision_enum.month,
        origin: EnumMemoryOrigin_enum.manual,
      ),
      () => dataSource.deleteStoryEvent('se-1'),
    ]);
  });

  test('saveMilestone stores unknown-date milestones in important_dates with year null', () async {
    when(
      () => dataSource.insertImportantDate(
        id: any(named: 'id'),
        coupleId: any(named: 'coupleId'),
        title: any(named: 'title'),
        kind: any(named: 'kind'),
        month: any(named: 'month'),
        day: any(named: 'day'),
        year: any(named: 'year'),
        yearly: any(named: 'yearly'),
      ),
    ).thenAnswer((_) async {
      return;
    });

    await repository.saveMilestone(
      id: 'ms-unknown',
      title: 'Primeira música',
      kind: MilestoneKind.first,
      precision: MilestoneDatePrecision.unknown,
      isShared: true,
      coupleId: 'couple-1',
    );

    verify(
      () => dataSource.insertImportantDate(
        id: 'ms-unknown',
        coupleId: 'couple-1',
        title: 'Primeira música',
        kind: EnumImportantDateKind_enum.first,
        month: 1,
        day: 1,
        year: null,
        yearly: false,
      ),
    ).called(1);
  });

  test('saveMilestone stores milestones with place in memories', () async {
    when(
      () => dataSource.insertMemory(
        id: any(named: 'id'),
        coupleId: any(named: 'coupleId'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        place: any(named: 'place'),
        happenedOn: any(named: 'happenedOn'),
        datePrecision: any(named: 'datePrecision'),
        origin: any(named: 'origin'),
      ),
    ).thenAnswer((_) async {
      return;
    });

    await repository.saveMilestone(
      id: 'ms-trip',
      title: 'Viagem para Paraty',
      kind: MilestoneKind.trip,
      precision: MilestoneDatePrecision.month,
      date: DateTime(2025, 7, 15),
      place: 'Paraty',
      isShared: false,
      coupleId: 'couple-1',
    );

    verify(
      () => dataSource.insertMemory(
        id: 'ms-trip',
        coupleId: null,
        title: 'Viagem para Paraty',
        body: null,
        place: 'Paraty',
        happenedOn: DateTime.utc(2025, 7, 1),
        datePrecision: EnumDatePrecision_enum.month,
        origin: EnumMemoryOrigin_enum.manual,
      ),
    ).called(1);
  });

  test('updateAvatarKind and updatePhase forward to data source', () async {
    when(
      () => dataSource.updateAvatarKind(
        profileId: any(named: 'profileId'),
        avatarKind: any(named: 'avatarKind'),
      ),
    ).thenAnswer((_) async {
      return;
    });
    when(
      () => dataSource.updatePhase(
        profileId: any(named: 'profileId'),
        phase: any(named: 'phase'),
      ),
    ).thenAnswer((_) async {
      return;
    });

    await repository.updateAvatarKind(profileId: 'p1', kind: AvatarKind.illustration);
    await repository.updatePhase(profileId: 'p1', phase: RelationshipPhase.engaged);

    verify(
      () => dataSource.updateAvatarKind(
        profileId: 'p1',
        avatarKind: EnumAvatarKind_enum.illustration,
      ),
    ).called(1);
    verify(() => dataSource.updatePhase(profileId: 'p1', phase: EnumRelationshipPhase_enum.engaged))
        .called(1);
  });
}
