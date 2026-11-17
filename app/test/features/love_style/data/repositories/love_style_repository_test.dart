import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/love_style/data/data_sources/remote/love_style_data_source.dart';
import 'package:app/features/love_style/data/repositories/love_style_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoveStyleDataSource() extends Mock implements LoveStyleDataSource;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late LoveStyleDataSource dataSource;
  late AuthenticationRepository authenticationRepository;
  late LoveStyleRepository repository;

  const first = ['time', 'words', 'acts', 'gifts', 'touch'];
  const retaken = ['touch', 'acts', 'gifts', 'words', 'time'];

  setUpAll(() {
    registerFallbackValue(<String>[]);
    registerFallbackValue(DateTime.utc(2026));
  });

  setUp(() {
    dataSource = _MockLoveStyleDataSource();
    authenticationRepository = _MockAuthenticationRepository();
    when(() => authenticationRepository.currentUserId).thenReturn('u1');
    repository = LoveStyleRepository(
      dataSource: dataSource,
      authenticationRepository: authenticationRepository,
    );
  });

  LoveStyleResultsRecord results({List<LoveStyleRecord> rows = const []}) =>
      (selfId: 'u1', rows: rows);

  group('overview', () {
    test('keeps the own result and the shared partner result apart', () async {
      when(() => dataSource.getResults()).thenAnswer(
        (_) async => results(
          rows: [
            (id: 'own', authorId: 'u1', ranked: first, sharedAt: null),
            (id: 'partner', authorId: 'u2', ranked: retaken, sharedAt: DateTime.utc(2026, 3)),
          ],
        ),
      );

      final overview = await repository.getOverview();

      expect(overview.own?.id, 'own');
      expect(overview.own?.isShared, isFalse);
      expect(overview.partner?.id, 'partner');
      expect(overview.canCompare, isTrue);
    });

    test('a person without a partner has no comparison', () async {
      when(() => dataSource.getResults()).thenAnswer(
        (_) async => results(rows: [(id: 'own', authorId: 'u1', ranked: first, sharedAt: null)]),
      );

      final overview = await repository.getOverview();

      expect(overview.partner, isNull);
      expect(overview.canCompare, isFalse);
    });
  });

  group('ranking', () {
    test('inserts the first ranking and returns its row id', () async {
      when(() => dataSource.getResults()).thenAnswer((_) async => results());
      when(() => dataSource.insertResult(any())).thenAnswer((_) async => 'q1');

      final id = await repository.saveRanked(first);

      expect(id, 'q1');
      verify(() => dataSource.insertResult(first)).called(1);
      verifyNever(
        () => dataSource.updateResult(
          id: any(named: 'id'),
          ranked: any(named: 'ranked'),
        ),
      );
    });

    test('a retake updates the saved row so the latest ranking wins', () async {
      when(() => dataSource.getResults()).thenAnswer(
        (_) async => results(rows: [(id: 'q1', authorId: 'u1', ranked: first, sharedAt: null)]),
      );
      when(
        () => dataSource.updateResult(
          id: any(named: 'id'),
          ranked: any(named: 'ranked'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      final id = await repository.saveRanked(retaken);

      expect(id, 'q1');
      verify(() => dataSource.updateResult(id: 'q1', ranked: retaken)).called(1);
      verifyNever(() => dataSource.insertResult(any()));
    });

    test('a race on the unique key falls back to updating the saved row', () async {
      var reads = 0;
      when(() => dataSource.getResults()).thenAnswer((_) async {
        reads++;

        return reads == 1
            ? results()
            : results(rows: [(id: 'q1', authorId: 'u1', ranked: first, sharedAt: null)]);
      });
      when(() => dataSource.insertResult(any()))
          .thenThrow(const LocalizedException(l10nKey: '23505'));
      when(
        () => dataSource.updateResult(
          id: any(named: 'id'),
          ranked: any(named: 'ranked'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      await repository.saveRanked(retaken);

      verify(() => dataSource.updateResult(id: 'q1', ranked: retaken)).called(1);
    });
  });

  group('sharing', () {
    test('sharing sends a time the server replaces with its own', () async {
      when(
        () => dataSource.setShared(
          id: any(named: 'id'),
          sharedAt: any(named: 'sharedAt'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      await repository.setShared(id: 'q1', isShared: true);

      final sharedAt = verify(
        () => dataSource.setShared(
          id: 'q1',
          sharedAt: captureAny(named: 'sharedAt'),
        ),
      ).captured.single;

      expect(sharedAt, isNotNull);
    });

    test('hiding the result clears the share time', () async {
      when(
        () => dataSource.setShared(
          id: any(named: 'id'),
          sharedAt: any(named: 'sharedAt'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      await repository.setShared(id: 'q1', isShared: false);

      verify(() => dataSource.setShared(id: 'q1', sharedAt: null)).called(1);
    });
  });

  group('manual entry', () {
    test('the first save inserts the loved entry', () async {
      when(() => dataSource.getManualEntry('u1')).thenAnswer((_) async => null);
      when(() => dataSource.insertManualEntry(any())).thenAnswer((_) async {
        return;
      });

      await repository.saveManualEntry('  Você se sente amado com tempo junto.  ');

      verify(() => dataSource.insertManualEntry('Você se sente amado com tempo junto.')).called(1);
      verifyNever(
        () => dataSource.updateManualEntry(
          id: any(named: 'id'),
          value: any(named: 'value'),
        ),
      );
    });

    test('a later save updates the existing entry', () async {
      when(() => dataSource.getManualEntry('u1'))
          .thenAnswer((_) async => (id: 'm1', value: 'Antigo'));
      when(
        () => dataSource.updateManualEntry(
          id: any(named: 'id'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      await repository.saveManualEntry('Novo');

      verify(() => dataSource.updateManualEntry(id: 'm1', value: 'Novo')).called(1);
      verifyNever(() => dataSource.insertManualEntry(any()));
    });

    test('the entry value is bounded to 1000 characters', () async {
      when(() => dataSource.getManualEntry('u1')).thenAnswer((_) async => null);
      when(() => dataSource.insertManualEntry(any())).thenAnswer((_) async {
        return;
      });

      await repository.saveManualEntry('a' * 1200);

      final saved = verify(() => dataSource.insertManualEntry(captureAny())).captured.single;

      expect((saved as String).length, 1000);
    });

    test('a race on the manual unique key updates the existing entry', () async {
      var reads = 0;
      when(() => dataSource.getManualEntry('u1')).thenAnswer((_) async {
        reads++;

        return reads == 1 ? null : (id: 'm1', value: 'Antigo');
      });
      when(() => dataSource.insertManualEntry(any()))
          .thenThrow(const LocalizedException(l10nKey: '23505'));
      when(
        () => dataSource.updateManualEntry(
          id: any(named: 'id'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {
        return;
      });

      await repository.saveManualEntry('Novo');

      verify(() => dataSource.updateManualEntry(id: 'm1', value: 'Novo')).called(1);
    });
  });
}
