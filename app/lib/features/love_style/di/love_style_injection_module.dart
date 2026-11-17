import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/love_style/data/data_sources/remote/love_style_data_source.dart';
import 'package:app/features/love_style/data/repositories/love_style_repository.dart';
import 'package:app/features/love_style/presentation/compare/cubit/love_style_compare_cubit.dart';
import 'package:app/features/love_style/presentation/exercise/cubit/love_style_cubit.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class LoveStyleInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<LoveStyleDataSource>(
      () => LoveStyleDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<LoveStyleRepository>(
      () => LoveStyleRepository(
        dataSource: injector.get<LoveStyleDataSource>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<LoveStyleCubit>(
      () => LoveStyleCubit(
        repository: injector.get<LoveStyleRepository>(),
        pairingRepository: injector.get<PairingRepository>(),
      ),
    )
    ..registerFactory<LoveStyleCompareCubit>(
      () => LoveStyleCompareCubit(
        repository: injector.get<LoveStyleRepository>(),
        pairingRepository: injector.get<PairingRepository>(),
      ),
    );
}
