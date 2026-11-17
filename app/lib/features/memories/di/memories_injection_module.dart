import 'package:app/features/memories/data/data_sources/remote/memories_data_source.dart';
import 'package:app/features/memories/data/repositories/memories_repository.dart';
import 'package:app/features/memories/presentation/jar/cubit/jar_cubit.dart';
import 'package:app/features/memories/presentation/memories/cubit/on_this_day_cubit.dart';
import 'package:app/features/memories/presentation/timeline/cubit/memories_cubit.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class MemoriesInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<MemoriesDataSource>(
      () => MemoriesDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<MemoriesRepository>(
      () => MemoriesRepository(
        dataSource: injector.get<MemoriesDataSource>(),
        togetherRepository: injector.get<TogetherRepository>(),
      ),
    )
    ..registerFactory<JarCubit>(
      () => JarCubit(memoriesRepository: injector.get<MemoriesRepository>()),
    )
    ..registerFactory<OnThisDayCubit>(
      () => OnThisDayCubit(memoriesRepository: injector.get<MemoriesRepository>()),
    )
    ..registerFactory<MemoriesCubit>(
      () => MemoriesCubit(memoriesRepository: injector.get<MemoriesRepository>()),
    );
}
