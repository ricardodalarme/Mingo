import 'package:app/features/connect/data/data_sources/remote/connect_data_source.dart';
import 'package:app/features/connect/data/repositories/connect_repository.dart';
import 'package:app/features/connect/presentation/us/cubit/us_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class ConnectInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<ConnectDataSource>(
      () => ConnectDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<ConnectRepository>(
      () => ConnectRepository(dataSource: injector.get<ConnectDataSource>()),
    )
    ..registerFactory<UsCubit>(() => UsCubit(connectRepository: injector.get<ConnectRepository>()));
}
