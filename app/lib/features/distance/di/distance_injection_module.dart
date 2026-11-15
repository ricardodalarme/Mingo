import 'package:app/features/dates/data/repositories/dates_repository.dart';
import 'package:app/features/distance/data/data_sources/remote/distance_data_source.dart';
import 'package:app/features/distance/data/repositories/distance_repository.dart';
import 'package:app/features/distance/presentation/distance/cubit/distance_cubit.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class DistanceInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<DistanceDataSource>(
      () => DistanceDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<DistanceRepository>(
      () => DistanceRepository(
        dataSource: injector.get<DistanceDataSource>(),
        profileRepository: injector.get<ProfileRepository>(),
        datesRepository: injector.get<DatesRepository>(),
      ),
    )
    ..registerFactory<DistanceCubit>(
      () => DistanceCubit(distanceRepository: injector.get<DistanceRepository>()),
    );
}
