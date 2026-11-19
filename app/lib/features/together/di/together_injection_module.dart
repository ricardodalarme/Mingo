import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/checkin/data/repositories/checkin_repository.dart';
import 'package:app/features/dates/data/repositories/dates_repository.dart';
import 'package:app/features/gifts/data/repositories/gifts_repository.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:app/features/lists/data/repositories/lists_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/questions/data/repositories/questions_repository.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/reminders/data/services/reminder_sync_service.dart';
import 'package:app/features/together/data/data_sources/remote/together_data_source.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:app/features/together/data/services/ritual_reminder_service.dart';
import 'package:app/features/together/presentation/date_night/cubit/date_night_cubit.dart';
import 'package:app/features/together/presentation/day/cubit/day_cubit.dart';
import 'package:app/features/together/presentation/logistics/cubit/logistics_cubit.dart';
import 'package:app/features/together/presentation/ritual_edit/cubit/ritual_edit_cubit.dart';
import 'package:app/features/together/presentation/rituals/cubit/rituals_cubit.dart';
import 'package:app/features/together/presentation/together/cubit/together_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class TogetherInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<TogetherDataSource>(
      () => TogetherDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<TogetherRepository>(
      () => TogetherRepository(
        dataSource: injector.get<TogetherDataSource>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<TogetherCubit>(
      () => TogetherCubit(
        pairingRepository: injector.get<PairingRepository>(),
        checkinRepository: injector.get<CheckinRepository>(),
        listsRepository: injector.get<ListsRepository>(),
        questionsRepository: injector.get<QuestionsRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
        giftsRepository: injector.get<GiftsRepository>(),
        historyRepository: injector.get<HistoryRepository>(),
      ),
    )
    ..registerLazySingleton<RitualReminderService>(
      () => RitualReminderService(
        remindersRepository: injector.get<RemindersRepository>(),
        syncService: injector.get<ReminderSyncService>(),
      ),
    )
    ..registerFactory<RitualsCubit>(
      () => RitualsCubit(
        togetherRepository: injector.get<TogetherRepository>(),
        reminderService: injector.get<RitualReminderService>(),
      ),
    )
    ..registerFactory<RitualEditCubit>(
      () => RitualEditCubit(
        togetherRepository: injector.get<TogetherRepository>(),
        reminderService: injector.get<RitualReminderService>(),
        profileRepository: injector.get<ProfileRepository>(),
        pairingRepository: injector.get<PairingRepository>(),
      ),
    )
    ..registerFactory<DayCubit>(
      () => DayCubit(
        datesRepository: injector.get<DatesRepository>(),
        togetherRepository: injector.get<TogetherRepository>(),
      ),
    )
    ..registerFactory<DateNightCubit>(
      () => DateNightCubit(
        togetherRepository: injector.get<TogetherRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
      ),
    )
    ..registerFactory<LogisticsCubit>(
      () => LogisticsCubit(
        togetherRepository: injector.get<TogetherRepository>(),
        pairingRepository: injector.get<PairingRepository>(),
      ),
    );
}
