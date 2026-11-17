import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/spice/data/data_sources/remote/spice_data_source.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:app/features/spice/presentation/cards/cubit/spice_cards_cubit.dart';
import 'package:app/features/spice/presentation/challenge/cubit/spice_challenge_cubit.dart';
import 'package:app/features/spice/presentation/desires/cubit/spice_desires_cubit.dart';
import 'package:app/features/spice/presentation/settings/cubit/spice_settings_cubit.dart';
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
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<SpiceCubit>(
      () => SpiceCubit(
        spiceRepository: injector.get<SpiceRepository>(),
        pairingRepository: injector.get<PairingRepository>(),
      ),
    )
    ..registerFactory<SpiceCardsCubit>(
      () => SpiceCardsCubit(spiceRepository: injector.get<SpiceRepository>()),
    )
    ..registerFactory<SpiceDesiresCubit>(
      () => SpiceDesiresCubit(spiceRepository: injector.get<SpiceRepository>()),
    )
    ..registerFactory<SpiceChallengeCubit>(
      () => SpiceChallengeCubit(spiceRepository: injector.get<SpiceRepository>()),
    )
    ..registerFactory<SpiceSettingsCubit>(
      () => SpiceSettingsCubit(spiceRepository: injector.get<SpiceRepository>()),
    );
}
