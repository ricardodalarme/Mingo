import 'package:app/features/agreements/data/models/agreement.dart';
import 'package:app/features/agreements/data/repositories/agreements_repository.dart';
import 'package:app/features/agreements/presentation/agreements/cubit/agreements_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository() extends Mock implements AgreementsRepository;

void main() {
  late AgreementsRepository repository;

  const waiting = Agreement(
    id: 'a',
    body: 'texto',
    isMine: false,
    isShared: true,
    isConfirmed: false,
  );

  setUp(() {
    repository = _MockRepository();
    when(repository.getCoupleId).thenAnswer((_) async => 'c');
    when(repository.getAgreements).thenAnswer((_) async => [waiting]);
  });

  test('load reads the agreements and the couple', () async {
    final cubit = AgreementsCubit(repository: repository);

    await cubit.load();

    expect(cubit.state.current, [waiting]);
    expect(cubit.state.coupleId, 'c');
  });

  test('confirming replaces the agreement with the confirmed one', () async {
    const confirmed = Agreement(
      id: 'a',
      body: 'texto',
      isMine: false,
      isShared: true,
      isConfirmed: true,
    );
    when(() => repository.confirmAgreement('a')).thenAnswer((_) async => confirmed);
    final cubit = AgreementsCubit(repository: repository);
    await cubit.load();

    await cubit.confirm(waiting);

    expect(cubit.state.current, [confirmed]);
  });

  test('putting one away removes it, and a failure keeps the list', () async {
    when(() => repository.archiveAgreement('a')).thenAnswer((_) async {});
    final cubit = AgreementsCubit(repository: repository);
    await cubit.load();

    await cubit.archive(waiting);
    expect(cubit.state.current, isEmpty);

    when(
      () => repository.addAgreement(
        id: any(named: 'id'),
        body: 'novo',
      ),
    ).thenThrow(Exception('x'));
    await cubit.add('novo');
    expect(cubit.state.current, isEmpty);
    expect(cubit.state.changeAction, isA<Initial>());
  });

  test('adding puts the saved agreement first', () async {
    const saved = Agreement(
      id: 'n',
      body: 'novo',
      isMine: true,
      isShared: true,
      isConfirmed: false,
    );
    when(
      () => repository.addAgreement(
        id: any(named: 'id'),
        body: 'novo',
      ),
    ).thenAnswer((_) async => saved);
    final cubit = AgreementsCubit(repository: repository);
    await cubit.load();

    await cubit.add('novo');

    expect(cubit.state.current.first, saved);
  });
}
