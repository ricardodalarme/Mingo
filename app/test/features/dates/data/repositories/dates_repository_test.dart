import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/dates_data_source.dart';
import 'package:app/features/dates/data/data_sources/remote/queries/generated/GiftIdeas.graphql.dart';
import 'package:app/features/dates/data/repositories/dates_repository.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDatesDataSource() extends Mock implements DatesDataSource;

class _MockTogetherRepository() extends Mock implements TogetherRepository;

QueryGiftIdeasgiftIdeasCollectionedgesnode _gift({required String id, required bool? isMine}) =>
    QueryGiftIdeasgiftIdeasCollectionedgesnode(
      id: id,
      title: id,
      status: EnumGiftIdeaStatus.idea,
      isMine: isMine,
    );

void main() {
  late DatesDataSource dataSource;
  late DatesRepository repository;

  setUp(() {
    dataSource = _MockDatesDataSource();
    repository = DatesRepository(
      dataSource: dataSource,
      togetherRepository: _MockTogetherRepository(),
    );
  });

  test('the gift list keeps only the gifts the caller added', () async {
    when(() => dataSource.getGiftIdeas()).thenAnswer(
      (_) async => [
        _gift(id: 'mine', isMine: true),
        _gift(id: 'partner', isMine: false),
        _gift(id: 'unknown', isMine: null),
      ],
    );

    final ideas = await repository.getGiftIdeas();

    expect(ideas.map((idea) => idea.id), ['mine']);
  });
}
