import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/dates_data_source.dart';
import 'package:app/features/dates/data/data_sources/remote/queries/generated/GiftIdeas.graphql.dart';
import 'package:app/features/dates/data/repositories/dates_repository.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDatesDataSource() extends Mock implements DatesDataSource;

class _MockTogetherRepository() extends Mock implements TogetherRepository;

QueryGiftIdeasgiftIdeas _gift({required String id, required String authorId}) =>
    QueryGiftIdeasgiftIdeas(
      id: id,
      title: id,
      status: EnumGiftIdeaStatus_enum.idea,
      authorId: authorId,
    );

void main() {
  late DatesDataSource dataSource;
  late TogetherRepository togetherRepository;
  late DatesRepository repository;

  setUp(() {
    dataSource = _MockDatesDataSource();
    togetherRepository = _MockTogetherRepository();
    repository = DatesRepository(dataSource: dataSource, togetherRepository: togetherRepository);
    when(togetherRepository.getCurrentUserId).thenAnswer((_) async => 'user-1');
  });

  test('the gift list keeps only the gifts the caller added', () async {
    when(() => dataSource.getGiftIdeas()).thenAnswer(
      (_) async => [
        _gift(id: 'mine', authorId: 'user-1'),
        _gift(id: 'partner', authorId: 'user-2'),
      ],
    );

    final ideas = await repository.getGiftIdeas();

    expect(ideas.map((idea) => idea.id), ['mine']);
  });
}
