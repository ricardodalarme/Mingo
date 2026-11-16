import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/spice/data/data_sources/remote/spice_data_source.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:app/features/spice/presentation/spice/cubit/spice_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class SpiceInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<SpiceDataSource>(
      () => SpiceDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<SpiceRepository>(
      () => SpiceRepository(
        dataSource: injector.get<SpiceDataSource>(),
        profileRepository: injector.get<ProfileRepository>(),
        plusRepository: injector.get<PlusRepository>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<SpiceCubit>(
      () => SpiceCubit(spiceRepository: injector.get<SpiceRepository>()),
    );
}
