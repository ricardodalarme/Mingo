import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/reminders/data/data_sources/local/reminders_local_data_source.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/reminders/data/services/reminder_sync_service.dart';
import 'package:core/core.dart';
import 'package:local_notification_service/local_notification_service.dart';
import 'package:preferences_service/preferences_service.dart';

class RemindersInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<LocalNotificationService>(LocalNotificationService.new)
    ..registerLazySingleton<RemindersLocalDataSource>(
      () => RemindersLocalDataSource(preferencesService: injector.get<PreferencesService>()),
    )
    ..registerLazySingleton<RemindersRepository>(
      () => RemindersRepository(
        localDataSource: injector.get<RemindersLocalDataSource>(),
        notificationService: injector.get<LocalNotificationService>(),
      ),
    )
    ..registerLazySingleton<ReminderSyncService>(
      () => ReminderSyncService(
        notificationsRepository: injector.get<NotificationsRepository>(),
        remindersRepository: injector.get<RemindersRepository>(),
      ),
    );
}
