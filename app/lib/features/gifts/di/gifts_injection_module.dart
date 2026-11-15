import 'package:app/features/gifts/data/data_sources/remote/gifts_data_source.dart';
import 'package:app/features/gifts/data/repositories/gifts_repository.dart';
import 'package:app/features/gifts/presentation/gifts/cubit/gifts_cubit.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class GiftsInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<GiftsDataSource>(
      () => GiftsDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<GiftsRepository>(
      () => GiftsRepository(
        dataSource: injector.get<GiftsDataSource>(),
        togetherRepository: injector.get<TogetherRepository>(),
      ),
    )
    ..registerFactory<GiftsCubit>(
      () => GiftsCubit(giftsRepository: injector.get<GiftsRepository>()),
    );
}
