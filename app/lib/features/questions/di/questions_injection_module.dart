import 'package:app/features/questions/data/data_sources/remote/questions_data_source.dart';
import 'package:app/features/questions/data/repositories/questions_repository.dart';
import 'package:app/features/questions/presentation/questions/cubit/questions_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class QuestionsInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<QuestionsDataSource>(
      () => QuestionsDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<QuestionsRepository>(
      () => QuestionsRepository(dataSource: injector.get<QuestionsDataSource>()),
    )
    ..registerFactory<QuestionsCubit>(
      () => QuestionsCubit(repository: injector.get<QuestionsRepository>()),
    );
}
