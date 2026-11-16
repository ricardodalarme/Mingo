import 'package:app/features/weekly_review/data/models/weekly_review.dart';
import 'package:app/features/weekly_review/data/repositories/weekly_review_repository.dart';
import 'package:app/features/weekly_review/presentation/weekly_review/cubit/weekly_review_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockWeeklyReviewRepository() extends Mock implements WeeklyReviewRepository;

void main() {
  late WeeklyReviewRepository repository;
  final review = WeeklyReview(
    weekStart: DateTime(2026, 11, 2),
    slips: 5,
    moodDays: 4,
    rituals: 2,
    isQuiet: false,
  );

  setUp(() => repository = _MockWeeklyReviewRepository());

  test('load shows the review', () async {
    when(repository.get).thenAnswer((_) async => review);
    final cubit = WeeklyReviewCubit(repository: repository);
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.review, Success(review));
  });

  test('a failed load shows a failure that can be retried', () async {
    when(repository.get).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = WeeklyReviewCubit(repository: repository);
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.review, isA<Failure>());
  });

  test('a failed refresh keeps the review on screen', () async {
    when(repository.get).thenAnswer((_) async => review);
    final cubit = WeeklyReviewCubit(repository: repository);
    addTearDown(cubit.close);
    await cubit.load();
    when(repository.get).thenThrow(Exception('offline'));

    await cubit.load();

    expect(cubit.state.review, Success(review));
  });
}
