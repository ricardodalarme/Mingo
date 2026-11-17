import 'package:app/features/account/data/data_sources/remote/account_data_source.dart';
import 'package:app/features/account/data/repositories/account_repository.dart';
import 'package:app/features/account/presentation/delete/cubit/delete_account_cubit.dart';
import 'package:app/features/account/presentation/export/cubit/export_data_cubit.dart';
import 'package:app/features/account/presentation/sign_out/cubit/sign_out_cubit.dart';
import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/today/data/repositories/today_repository.dart';
import 'package:biometric_service/biometric_service.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:preferences_service/preferences_service.dart';
import 'package:secure_storage_service/secure_storage_service.dart';

class AccountInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<AccountDataSource>(
      () => AccountDataSource(
        client: injector.get<GQLClient>(),
        restClient: injector.get<RestClient>(),
      ),
    )
    ..registerLazySingleton<AccountRepository>(
      () => AccountRepository(
        dataSource: injector.get<AccountDataSource>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<DeleteAccountCubit>(
      () => DeleteAccountCubit(
        repository: injector.get<AccountRepository>(),
        pairingRepository: injector.get<PairingRepository>(),
        biometricService: injector.get<BiometricService>(),
      ),
    )
    ..registerFactory<ExportDataCubit>(
      () => ExportDataCubit(repository: injector.get<AccountRepository>()),
    )
    ..registerFactory<SignOutCubit>(
      () => SignOutCubit(
        authenticationRepository: injector.get<AuthenticationRepository>(),
        appCubit: injector.get<AppCubit>(),
        slipRepository: injector.get<SlipRepository>(),
        remindersRepository: injector.get<RemindersRepository>(),
        preferencesService: injector.get<PreferencesService>(),
        secureStorageService: injector.get<SecureStorageService>(),
        todayRepository: injector.get<TodayRepository>(),
        moodRepository: injector.get<MoodRepository>(),
      ),
    );
}
