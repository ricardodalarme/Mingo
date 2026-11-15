import 'package:app/features/privacy/data/data_sources/remote/privacy_data_source.dart';
import 'package:app/features/privacy/data/repositories/privacy_repository.dart';
import 'package:app/features/privacy/presentation/consents/cubit/consents_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class PrivacyInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<PrivacyDataSource>(
      () => PrivacyDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<PrivacyRepository>(
      () => PrivacyRepository(dataSource: injector.get<PrivacyDataSource>()),
    )
    ..registerFactory<ConsentsCubit>(
      () => ConsentsCubit(repository: injector.get<PrivacyRepository>()),
    );
}
