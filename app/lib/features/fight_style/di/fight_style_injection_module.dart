import 'package:app/features/fight_style/data/data_sources/remote/fight_style_data_source.dart';
import 'package:app/features/fight_style/data/repositories/fight_style_repository.dart';
import 'package:app/features/fight_style/presentation/exercise/cubit/fight_style_cubit.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class FightStyleInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<FightStyleDataSource>(
      () => FightStyleDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<FightStyleRepository>(
      () => FightStyleRepository(dataSource: injector.get<FightStyleDataSource>()),
    )
    ..registerFactory<FightStyleCubit>(
      () => FightStyleCubit(
        repository: injector.get<FightStyleRepository>(),
        pairingRepository: injector.get<PairingRepository>(),
      ),
    );
}
