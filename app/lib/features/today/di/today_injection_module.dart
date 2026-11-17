import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/repair/data/repositories/repair_repository.dart';
import 'package:app/features/today/data/data_sources/local/today_local_data_source.dart';
import 'package:app/features/today/data/data_sources/remote/today_data_source.dart';
import 'package:app/features/today/data/repositories/today_repository.dart';
import 'package:app/features/today/presentation/today/cubit/today_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:preferences_service/preferences_service.dart';

class TodayInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<TodayDataSource>(
      () => TodayDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<TodayLocalDataSource>(
      () => TodayLocalDataSource(preferencesService: injector.get<PreferencesService>()),
    )
    ..registerLazySingleton<TodayRepository>(
      () => TodayRepository(
        dataSource: injector.get<TodayDataSource>(),
        localDataSource: injector.get<TodayLocalDataSource>(),
      ),
    )
    ..registerFactory<TodayCubit>(
      () => TodayCubit(
        todayRepository: injector.get<TodayRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
        repairRepository: injector.get<RepairRepository>(),
      ),
    );
}
