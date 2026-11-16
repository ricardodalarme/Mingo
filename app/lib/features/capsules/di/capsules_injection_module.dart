import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/capsules/data/data_sources/remote/capsules_data_source.dart';
import 'package:app/features/capsules/data/repositories/capsules_repository.dart';
import 'package:app/features/capsules/presentation/capsules/cubit/capsules_cubit.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class CapsulesInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<CapsulesDataSource>(
      () => CapsulesDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<CapsulesRepository>(
      () => CapsulesRepository(
        dataSource: injector.get<CapsulesDataSource>(),
        togetherRepository: injector.get<TogetherRepository>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<CapsulesCubit>(
      () => CapsulesCubit(capsulesRepository: injector.get<CapsulesRepository>()),
    );
}
