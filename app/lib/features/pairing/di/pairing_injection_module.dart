import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/pairing/data/data_sources/local/pairing_local_data_source.dart';
import 'package:app/features/pairing/data/data_sources/remote/pairing_data_source.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/features/pairing/presentation/invite/cubit/invite_cubit.dart';
import 'package:app/features/pairing/presentation/relationship/cubit/relationship_changed_cubit.dart';
import 'package:app/features/pairing/presentation/relationship/cubit/relationship_settings_cubit.dart';
import 'package:app/features/pairing/presentation/unpair/cubit/unpair_cubit.dart';
import 'package:app/features/pairing/presentation/unpair/cubit/unpair_done_cubit.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/today/data/repositories/today_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:preferences_service/preferences_service.dart';
import 'package:secure_storage_service/secure_storage_service.dart';
import 'package:share_service/share_service.dart';

class PairingInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<PairingDataSource>(
      () => PairingDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<PairingLocalDataSource>(
      () => PairingLocalDataSource(secureStorageService: injector.get<SecureStorageService>()),
    )
    ..registerLazySingleton<InviteCodeStore>(
      () => InviteCodeStore(preferencesService: injector.get<PreferencesService>()),
    )
    ..registerLazySingleton<PairingRepository>(
      () => PairingRepository(
        pairingDataSource: injector.get<PairingDataSource>(),
        localDataSource: injector.get<PairingLocalDataSource>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<AcceptInviteCubit>(
      () => AcceptInviteCubit(
        pairingRepository: injector.get<PairingRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
        inviteCodes: injector.get<InviteCodeStore>(),
      ),
    )
    ..registerFactory<InviteCubit>(
      () => InviteCubit(
        pairingRepository: injector.get<PairingRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
        shareService: injector.get<ShareService>(),
      ),
    )
    ..registerFactory<RelationshipSettingsCubit>(
      () => RelationshipSettingsCubit(
        profileRepository: injector.get<ProfileRepository>(),
        pairingRepository: injector.get<PairingRepository>(),
      ),
    )
    ..registerFactory<RelationshipChangedCubit>(
      () => RelationshipChangedCubit(profileRepository: injector.get<ProfileRepository>()),
    )
    ..registerFactory<UnpairCubit>(
      () => UnpairCubit(
        pairingRepository: injector.get<PairingRepository>(),
        todayRepository: injector.get<TodayRepository>(),
        moodRepository: injector.get<MoodRepository>(),
      ),
    )
    ..registerFactory<UnpairDoneCubit>(
      () => UnpairDoneCubit(pairingRepository: injector.get<PairingRepository>()),
    );
}
