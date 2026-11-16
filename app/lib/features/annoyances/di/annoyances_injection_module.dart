import 'package:app/features/annoyances/data/data_sources/remote/annoyance_data_source.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/annoyances/presentation/annoyance_check/cubit/annoyance_check_cubit.dart';
import 'package:app/features/annoyances/presentation/gentle_request/cubit/gentle_request_cubit.dart';
import 'package:app/features/annoyances/presentation/gentle_request_detail/cubit/gentle_request_detail_cubit.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class AnnoyancesInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<AnnoyanceDataSource>(
      () => AnnoyanceDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<AnnoyanceRepository>(
      () => AnnoyanceRepository(dataSource: injector.get<AnnoyanceDataSource>()),
    )
    ..registerFactory<AnnoyanceCheckCubit>(
      () => AnnoyanceCheckCubit(annoyanceRepository: injector.get<AnnoyanceRepository>()),
    )
    ..registerFactory<GentleRequestDetailCubit>(
      () => GentleRequestDetailCubit(
        annoyanceRepository: injector.get<AnnoyanceRepository>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<GentleRequestCubit>(
      () => GentleRequestCubit(
        annoyanceRepository: injector.get<AnnoyanceRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
      ),
    );
}
