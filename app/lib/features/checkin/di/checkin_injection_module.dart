import 'package:app/features/checkin/data/data_sources/local/checkin_local_data_source.dart';
import 'package:app/features/checkin/data/data_sources/remote/checkin_data_source.dart';
import 'package:app/features/checkin/data/repositories/checkin_repository.dart';
import 'package:app/features/checkin/presentation/checkin/cubit/checkin_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:preferences_service/preferences_service.dart';

class CheckinInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<CheckinDataSource>(
      () => CheckinDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<CheckinLocalDataSource>(
      () => CheckinLocalDataSource(preferencesService: injector.get<PreferencesService>()),
    )
    ..registerLazySingleton<CheckinRepository>(
      () => CheckinRepository(
        dataSource: injector.get<CheckinDataSource>(),
        localDataSource: injector.get<CheckinLocalDataSource>(),
      ),
    )
    ..registerFactory<CheckinCubit>(
      () => CheckinCubit(repository: injector.get<CheckinRepository>()),
    );
}
