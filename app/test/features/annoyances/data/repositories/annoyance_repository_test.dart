import 'package:app/features/annoyances/data/data_sources/remote/annoyance_data_source.dart';
import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/SaveAnnoyance.graphql.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAnnoyanceDataSource() extends Mock implements AnnoyanceDataSource;

void main() {
  late AnnoyanceDataSource remote;
  late AnnoyanceRepository repository;

  setUp(() {
    remote = _MockAnnoyanceDataSource();
    repository = AnnoyanceRepository(dataSource: remote);
  });

  test('saving trims the text and returns the annoyance with its expiry', () async {
    when(() => remote.save('Chegou tarde')).thenAnswer(
      (_) async => MutationSaveAnnoyanceinsertAnnoyancesOne(
        id: 'a1',
        body: 'Chegou tarde',
        createdAt: DateTime.utc(2026, 11, 1),
        expiresAt: DateTime.utc(2026, 11, 15),
      ),
    );

    final annoyance = await repository.save('  Chegou tarde  ');

    expect(annoyance.id, 'a1');
    expect(annoyance.expiresAt, DateTime.utc(2026, 11, 15));
  });

  test('a gentle request goes out trimmed with the annoyance it came from', () async {
    when(
      () => remote.sendGentleRequest(
        whenText: any(named: 'whenText'),
        feelText: any(named: 'feelText'),
        wishText: any(named: 'wishText'),
        annoyanceId: any(named: 'annoyanceId'),
      ),
    ).thenAnswer((_) async => true);

    await repository.sendGentleRequest(
      whenText: ' chego em casa ',
      feelText: ' sozinha ',
      wishText: ' dividir a tarde ',
      annoyanceId: 'a1',
    );

    verify(
      () => remote.sendGentleRequest(
        whenText: 'chego em casa',
        feelText: 'sozinha',
        wishText: 'dividir a tarde',
        annoyanceId: 'a1',
      ),
    ).called(1);
  });

  test('a request without a partner fails as not paired', () {
    when(
      () => remote.sendGentleRequest(
        whenText: any(named: 'whenText'),
        feelText: any(named: 'feelText'),
        wishText: any(named: 'wishText'),
        annoyanceId: any(named: 'annoyanceId'),
      ),
    ).thenAnswer((_) async => false);

    expect(
      () => repository.sendGentleRequest(whenText: 'a', feelText: 'b', wishText: 'c'),
      throwsA(isA<LocalizedException>().having((e) => e.l10nKey, 'key', 'NOT_PAIRED')),
    );
  });

  test('letting go deletes the annoyance', () async {
    when(() => remote.delete('a1')).thenAnswer((_) async {});

    await repository.delete('a1');

    verify(() => remote.delete('a1')).called(1);
  });
}
