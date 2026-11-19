import 'package:app/features/diary/data/data_sources/remote/diary_data_source.dart';
import 'package:app/features/diary/data/repositories/diary_repository.dart';
import 'package:app/features/diary/presentation/diary/cubit/diary_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class DiaryInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<DiaryDataSource>(
      () => DiaryDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<DiaryRepository>(
      () => DiaryRepository(dataSource: injector.get<DiaryDataSource>()),
    )
    ..registerFactory<DiaryCubit>(() => DiaryCubit(repository: injector.get<DiaryRepository>()));
}
