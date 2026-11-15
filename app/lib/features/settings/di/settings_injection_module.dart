import 'package:app/features/account/data/repositories/account_repository.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/settings/data/data_sources/local/settings_local_data_source.dart';
import 'package:app/features/settings/data/repositories/settings_repository.dart';
import 'package:app/features/settings/presentation/home/cubit/settings_home_cubit.dart';
import 'package:app/features/settings/presentation/language/cubit/language_cubit.dart';
import 'package:core/core.dart';
import 'package:preferences_service/preferences_service.dart';

class SettingsInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<SettingsLocalDataSource>(
      () => SettingsLocalDataSource(preferencesService: injector.get<PreferencesService>()),
    )
    ..registerFactory<LanguageCubit>(
      () => LanguageCubit(repository: injector.get<SettingsRepository>()),
    )
    ..registerFactory<SettingsHomeCubit>(
      () => SettingsHomeCubit(
        pairingRepository: injector.get<PairingRepository>(),
        plusRepository: injector.get<PlusRepository>(),
        notificationsRepository: injector.get<NotificationsRepository>(),
        accountRepository: injector.get<AccountRepository>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepository(localDataSource: injector.get<SettingsLocalDataSource>()),
    );
}
