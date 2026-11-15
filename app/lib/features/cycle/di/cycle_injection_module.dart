import 'package:app/features/cycle/data/data_sources/remote/cycle_data_source.dart';
import 'package:app/features/cycle/data/repositories/cycle_repository.dart';
import 'package:app/features/cycle/presentation/sensitive_days/cubit/sensitive_days_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class CycleInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<CycleDataSource>(
      () => CycleDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<CycleRepository>(
      () => CycleRepository(dataSource: injector.get<CycleDataSource>()),
    )
    ..registerFactory<SensitiveDaysCubit>(
      () => SensitiveDaysCubit(cycleRepository: injector.get<CycleRepository>()),
    );
}
