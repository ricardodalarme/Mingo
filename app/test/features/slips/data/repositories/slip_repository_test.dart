import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/slips/data/data_sources/local/slip_local_data_source.dart';
import 'package:app/features/slips/data/data_sources/remote/slip_data_source.dart';
import 'package:app/features/slips/data/models/pending_slip.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_draft.dart';
import 'package:app/features/slips/data/models/slip_polarity.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockSlipDataSource() extends Mock implements SlipDataSource;

class _MockSlipLocalDataSource() extends Mock implements SlipLocalDataSource;

void main() {
  late SlipDataSource remote;
  late SlipLocalDataSource local;
  late SlipRepository repository;
  final createdAt = DateTime.utc(2026, 11, 9, 20);

  setUpAll(() {
    registerFallbackValue(<PendingSlip>[]);
    registerFallbackValue(SlipDraft(text: '', savedAt: DateTime(2026)));
    registerFallbackValue(EnumSlipKind_enum.quick);
    registerFallbackValue(EnumSlipPolarity_enum.liked);
    registerFallbackValue(EnumSlipCategory_enum.did);
    registerFallbackValue(EnumWorkArea_enum.other);
  });

  setUp(() {
    remote = _MockSlipDataSource();
    local = _MockSlipLocalDataSource();
    repository = SlipRepository(slipDataSource: remote, localDataSource: local);
    when(() => local.readPending()).thenReturn(const []);
    when(() => local.writePending(any())).thenAnswer((_) async {
      return;
    });
    when(
      () => remote.saveSlip(
        id: any(named: 'id'),
        body: any(named: 'body'),
        createdAt: any(named: 'createdAt'),
        kind: any(named: 'kind'),
        feeling: any(named: 'feeling'),
        planNote: any(named: 'planNote'),
        polarity: any(named: 'polarity'),
        request: any(named: 'request'),
        category: any(named: 'category'),
        workArea: any(named: 'workArea'),
      ),
    ).thenAnswer((_) async {
      return;
    });
  });

  group('saveQuick', () {
    test('sends the slip with its category and reports synced', () async {
      final outcome = await repository.saveQuick(
        id: 's1',
        body: 'Fez café',
        createdAt: createdAt,
        category: SlipCategory.did,
      );

      expect(outcome, SlipSaveOutcome.synced);
      verify(
        () => remote.saveSlip(
          id: 's1',
          body: 'Fez café',
          createdAt: createdAt,
          kind: EnumSlipKind_enum.quick,
          feeling: null,
          planNote: null,
          polarity: EnumSlipPolarity_enum.liked,
          request: null,
          category: EnumSlipCategory_enum.did,
          workArea: null,
        ),
      ).called(1);
    });

    test('sends a bothered slip with its polarity', () async {
      await repository.saveQuick(
        id: 's1',
        body: 'Chegou tarde sem avisar',
        createdAt: createdAt,
        polarity: SlipPolarity.bothered,
      );

      verify(
        () => remote.saveSlip(
          id: 's1',
          body: 'Chegou tarde sem avisar',
          createdAt: createdAt,
          kind: EnumSlipKind_enum.quick,
          feeling: null,
          planNote: null,
          polarity: EnumSlipPolarity_enum.bothered,
          request: null,
          category: null,
          workArea: null,
        ),
      ).called(1);
    });

    test('trims the gentle request and sends it with the slip', () async {
      await repository.saveQuick(
        id: 's1',
        body: 'Chegou tarde sem avisar',
        createdAt: createdAt,
        polarity: SlipPolarity.bothered,
        request: '  Poderia me avisar antes?  ',
      );

      verify(
        () => remote.saveSlip(
          id: 's1',
          body: 'Chegou tarde sem avisar',
          createdAt: createdAt,
          kind: EnumSlipKind_enum.quick,
          feeling: null,
          planNote: null,
          polarity: EnumSlipPolarity_enum.bothered,
          request: 'Poderia me avisar antes?',
          category: null,
          workArea: null,
        ),
      ).called(1);
    });

    test('a blank request is sent as null', () async {
      await repository.saveQuick(
        id: 's1',
        body: 'Chegou tarde sem avisar',
        createdAt: createdAt,
        polarity: SlipPolarity.bothered,
        request: '   ',
      );

      verify(
        () => remote.saveSlip(
          id: 's1',
          body: 'Chegou tarde sem avisar',
          createdAt: createdAt,
          kind: EnumSlipKind_enum.quick,
          feeling: null,
          planNote: null,
          polarity: EnumSlipPolarity_enum.bothered,
          request: null,
          category: null,
          workArea: null,
        ),
      ).called(1);
    });

    test('keeps the slip on the device when offline', () async {
      when(
        () => remote.saveSlip(
          id: any(named: 'id'),
          body: any(named: 'body'),
          createdAt: any(named: 'createdAt'),
          kind: any(named: 'kind'),
          feeling: any(named: 'feeling'),
          planNote: any(named: 'planNote'),
          polarity: any(named: 'polarity'),
          request: any(named: 'request'),
          category: any(named: 'category'),
          workArea: any(named: 'workArea'),
        ),
      ).thenAnswer((_) async => throw const LocalizedException(l10nKey: networkErrorCode));

      final outcome = await repository.saveQuick(id: 's1', body: 'Fez café', createdAt: createdAt);

      expect(outcome, SlipSaveOutcome.queued);
      final saved = verify(() => local.writePending(captureAny())).captured.single;
      expect((saved as List<PendingSlip>).single.id, 's1');
    });

    test('rethrows a server rejection instead of queueing it', () {
      when(
        () => remote.saveSlip(
          id: any(named: 'id'),
          body: any(named: 'body'),
          createdAt: any(named: 'createdAt'),
          kind: any(named: 'kind'),
          feeling: any(named: 'feeling'),
          planNote: any(named: 'planNote'),
          polarity: any(named: 'polarity'),
          request: any(named: 'request'),
          category: any(named: 'category'),
          workArea: any(named: 'workArea'),
        ),
      ).thenAnswer((_) async => throw const LocalizedException(l10nKey: 'FREE_LIMIT_REACHED'));

      expect(
        () => repository.saveQuick(id: 's1', body: 'x', createdAt: createdAt),
        throwsA(isA<LocalizedException>()),
      );
      verifyNever(() => local.writePending(any()));
    });
  });

  group('undo', () {
    test('only drops a slip that never left the device', () async {
      when(() => local.readPending())
          .thenReturn([PendingSlip(id: 's1', body: 'x', createdAt: createdAt)]);

      await repository.undo('s1');

      verifyNever(() => remote.deleteSlip(any()));
      final saved = verify(() => local.writePending(captureAny())).captured.single;
      expect(saved, isEmpty);
    });

    test('deletes a synced slip on the server', () async {
      when(() => remote.deleteSlip('s1')).thenAnswer((_) async {
        return;
      });

      await repository.undo('s1');

      verify(() => remote.deleteSlip('s1')).called(1);
    });
  });

  group('flushPending', () {
    test('sends waiting slips and clears them', () async {
      final slip = PendingSlip(id: 's1', body: 'x', createdAt: createdAt);
      var calls = 0;
      when(() => local.readPending()).thenAnswer((_) => calls++ == 0 ? [slip] : const []);

      await repository.flushPending();

      verify(
        () => remote.saveSlip(
          id: 's1',
          body: 'x',
          createdAt: createdAt,
          kind: EnumSlipKind_enum.quick,
          feeling: null,
          planNote: null,
          polarity: EnumSlipPolarity_enum.liked,
          request: null,
          category: null,
          workArea: null,
        ),
      ).called(1);
      verify(() => local.writePending(const [])).called(1);
    });
  });

  group('sendHug', () {
    test('sends the one-tap hug signal to the partner', () async {
      when(() => remote.sendHug()).thenAnswer((_) async {});

      await repository.sendHug();

      verify(() => remote.sendHug()).called(1);
    });
  });

  group('askToTalk', () {
    test('sends the talk need to the partner', () async {
      when(() => remote.sendNeed(value: any(named: 'value'))).thenAnswer((_) async {});

      await repository.askToTalk();

      verify(() => remote.sendNeed(value: 'talk')).called(1);
    });
  });

  group('sendSweetMessage', () {
    test('sends the message as the body of a hug', () async {
      when(() => remote.sendHug(body: any(named: 'body'))).thenAnswer((_) async {});

      await repository.sendSweetMessage('Sem pressa. Estou por aqui.');

      verify(() => remote.sendHug(body: 'Sem pressa. Estou por aqui.')).called(1);
    });
  });

  group('draft', () {
    test('ignores a draft older than an hour', () {
      final now = DateTime.utc(2026, 11, 9, 22);
      when(() => local.readDraft())
          .thenReturn(SlipDraft(text: 'x', savedAt: now.subtract(const Duration(hours: 2))));

      expect(repository.readDraft(now), isNull);
    });

    test('returns a fresh draft', () {
      final now = DateTime.utc(2026, 11, 9, 22);
      final draft = SlipDraft(text: 'x', savedAt: now.subtract(const Duration(minutes: 10)));
      when(() => local.readDraft()).thenReturn(draft);

      expect(repository.readDraft(now), draft);
    });
  });
}
