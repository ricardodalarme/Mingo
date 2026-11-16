import 'package:app/features/_shared/data/data_sources/local/device_marker_store.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/notifications/data/data_sources/local/notifications_local_data_source.dart';
import 'package:app/features/notifications/data/data_sources/remote/inbox_data_source.dart';
import 'package:app/features/notifications/data/data_sources/remote/notifications_data_source.dart';
import 'package:app/features/notifications/data/repositories/inbox_repository.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/notifications/presentation/bell/cubit/inbox_badge_cubit.dart';
import 'package:app/features/notifications/presentation/inbox/cubit/inbox_cubit.dart';
import 'package:app/features/notifications/presentation/off_banner/cubit/notifications_off_cubit.dart';
import 'package:app/features/notifications/presentation/permission/cubit/notification_permission_cubit.dart';
import 'package:app/features/notifications/presentation/preferences/cubit/notification_preferences_cubit.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/reminders/data/services/reminder_sync_service.dart';
import 'package:core/core.dart';
import 'package:device_info_service/device_info_service.dart';
import 'package:network/network.dart';
import 'package:notification_service/notification_service.dart';
import 'package:permission_service/permission_service.dart';
import 'package:preferences_service/preferences_service.dart';

class NotificationsInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<NotificationsDataSource>(
      () => NotificationsDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<NotificationsLocalDataSource>(
      () => NotificationsLocalDataSource(preferencesService: injector.get<PreferencesService>()),
    )
    ..registerLazySingleton<NotificationsRepository>(
      () => NotificationsRepository(
        dataSource: injector.get<NotificationsDataSource>(),
        localDataSource: injector.get<NotificationsLocalDataSource>(),
        notificationService: injector.get<NotificationService>(),
        permissionService: injector.get<PermissionService>(),
        deviceInfoService: injector.get<DeviceInfoService>(),
        markerStore: injector.get<DeviceMarkerStore>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerLazySingleton<InboxDataSource>(
      () => InboxDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<InboxRepository>(
      () => InboxRepository(dataSource: injector.get<InboxDataSource>()),
    )
    ..registerFactory<InboxCubit>(
      () => InboxCubit(
        inboxRepository: injector.get<InboxRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
      ),
    )
    ..registerFactory<InboxBadgeCubit>(
      () => InboxBadgeCubit(inboxRepository: injector.get<InboxRepository>()),
    )
    ..registerFactory<NotificationPermissionCubit>(
      () => NotificationPermissionCubit(repository: injector.get<NotificationsRepository>()),
    )
    ..registerFactory<NotificationPreferencesCubit>(
      () => NotificationPreferencesCubit(
        notificationsRepository: injector.get<NotificationsRepository>(),
        remindersRepository: injector.get<RemindersRepository>(),
        syncService: injector.get<ReminderSyncService>(),
      ),
    )
    ..registerFactory<NotificationsOffCubit>(
      () => NotificationsOffCubit(repository: injector.get<NotificationsRepository>()),
    );
}
