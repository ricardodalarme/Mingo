import 'package:app/features/agreements/data/data_sources/remote/agreements_data_source.dart';
import 'package:app/features/agreements/data/repositories/agreements_repository.dart';
import 'package:app/features/agreements/presentation/agreements/cubit/agreements_cubit.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class AgreementsInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<AgreementsDataSource>(
      () => AgreementsDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<AgreementsRepository>(
      () => AgreementsRepository(
        dataSource: injector.get<AgreementsDataSource>(),
        togetherRepository: injector.get<TogetherRepository>(),
      ),
    )
    ..registerFactory<AgreementsCubit>(
      () => AgreementsCubit(repository: injector.get<AgreementsRepository>()),
    );
}
