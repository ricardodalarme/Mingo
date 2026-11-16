import 'package:app/features/weekly_review/data/data_sources/remote/weekly_review_data_source.dart';
import 'package:app/features/weekly_review/data/repositories/weekly_review_repository.dart';
import 'package:app/features/weekly_review/presentation/weekly_review/cubit/weekly_review_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class WeeklyReviewInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<WeeklyReviewDataSource>(
      () => WeeklyReviewDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<WeeklyReviewRepository>(
      () => WeeklyReviewRepository(dataSource: injector.get<WeeklyReviewDataSource>()),
    )
    ..registerFactory<WeeklyReviewCubit>(
      () => WeeklyReviewCubit(repository: injector.get<WeeklyReviewRepository>()),
    );
}
