import 'package:app/features/agreements/data/data_sources/remote/agreements_data_source.dart';
import 'package:app/features/agreements/data/data_sources/remote/fragments/generated/AgreementFragment.graphql.dart';
import 'package:app/features/agreements/data/repositories/agreements_repository.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDataSource() extends Mock implements AgreementsDataSource;

class _MockTogether() extends Mock implements TogetherRepository;

void main() {
  late AgreementsDataSource dataSource;
  late TogetherRepository together;
  late AgreementsRepository repository;

  FragmentAgreementFragment node({
    required String id,
    required String authorId,
    String? coupleId,
    DateTime? confirmedAt,
  }) => FragmentAgreementFragment(
    id: id,
    body: 'texto',
    authorId: authorId,
    coupleId: coupleId,
    confirmedAt: confirmedAt,
  );

  setUp(() {
    dataSource = _MockDataSource();
    together = _MockTogether();
    repository = AgreementsRepository(dataSource: dataSource, togetherRepository: together);
    when(together.getCurrentUserId).thenAnswer((_) async => 'me');
  });

  test('ownership, sharing and confirmation come from the stored row', () async {
    when(dataSource.getAgreements).thenAnswer(
      (_) async => [
        node(id: 'a', authorId: 'me'),
        node(id: 'b', authorId: 'you', coupleId: 'c'),
        node(id: 'c', authorId: 'you', coupleId: 'c', confirmedAt: DateTime(2026)),
      ],
    );

    final agreements = await repository.getAgreements();

    expect(agreements[0].isShared, isFalse);
    expect(agreements[1].needsMyConfirmation, isTrue);
    expect(agreements[2].isConfirmed, isTrue);
    expect(agreements[2].needsMyConfirmation, isFalse);
  });

  test('a new agreement is shared with the couple when there is one', () async {
    when(together.getCoupleId).thenAnswer((_) async => 'c');
    when(() => dataSource.addAgreement(id: 'x', body: 'texto', coupleId: 'c'))
        .thenAnswer((_) async => node(id: 'x', authorId: 'me', coupleId: 'c'));

    final saved = await repository.addAgreement(id: 'x', body: '  texto ');

    expect(saved.isShared, isTrue);
    expect(saved.isWaitingForPartner, isTrue);
  });
}
