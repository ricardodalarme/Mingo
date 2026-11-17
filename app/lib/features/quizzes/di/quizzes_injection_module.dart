import 'package:app/features/quizzes/data/data_sources/remote/quizzes_data_source.dart';
import 'package:app/features/quizzes/data/repositories/quizzes_repository.dart';
import 'package:app/features/quizzes/presentation/hub/cubit/quizzes_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class QuizzesInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<QuizzesDataSource>(
      () => QuizzesDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<QuizzesRepository>(
      () => QuizzesRepository(dataSource: injector.get<QuizzesDataSource>()),
    )
    ..registerFactory<QuizzesCubit>(
      () => QuizzesCubit(repository: injector.get<QuizzesRepository>()),
    );
}
