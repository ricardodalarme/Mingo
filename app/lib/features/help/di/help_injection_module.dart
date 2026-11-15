import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/help/data/data_sources/local/support_local_data_source.dart';
import 'package:app/features/help/data/data_sources/remote/support_data_source.dart';
import 'package:app/features/help/data/repositories/support_repository.dart';
import 'package:app/features/help/data/services/support_app_version_service.dart';
import 'package:app/features/help/presentation/help/cubit/help_hub_cubit.dart';
import 'package:app/features/help/presentation/support/cubit/support_cubit.dart';
import 'package:app_info_service/app_info_service.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:preferences_service/preferences_service.dart';

class HelpInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<SupportDataSource>(
      () => SupportDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<SupportLocalDataSource>(
      () => SupportLocalDataSource(preferencesService: injector.get<PreferencesService>()),
    )
    ..registerLazySingleton<SupportAppVersionService>(
      () => SupportAppVersionService(appInfoService: injector.get<AppInfoService>()),
    )
    ..registerLazySingleton<SupportRepository>(
      () => SupportRepository(
        dataSource: injector.get<SupportDataSource>(),
        localDataSource: injector.get<SupportLocalDataSource>(),
      ),
    )
    ..registerFactory<HelpHubCubit>(
      () => HelpHubCubit(
        repository: injector.get<SupportRepository>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<SupportCubit>(
      () => SupportCubit(
        repository: injector.get<SupportRepository>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
        appVersionService: injector.get<SupportAppVersionService>(),
      ),
    );
}
