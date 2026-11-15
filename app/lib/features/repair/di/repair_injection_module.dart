import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/reminders/data/services/reminder_sync_service.dart';
import 'package:app/features/repair/data/data_sources/remote/repair_data_source.dart';
import 'package:app/features/repair/data/repositories/repair_repository.dart';
import 'package:app/features/repair/presentation/guided/cubit/guided_repair_cubit.dart';
import 'package:app/features/repair/presentation/learning/cubit/learning_cubit.dart';
import 'package:app/features/repair/presentation/quick_repair/cubit/quick_repair_cubit.dart';
import 'package:app/features/repair/presentation/received/cubit/received_signals_cubit.dart';
import 'package:app/features/repair/presentation/soft_start/cubit/soft_start_cubit.dart';
import 'package:app/features/repair/presentation/temperature/cubit/temperature_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class RepairInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<RepairDataSource>(
      () => RepairDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<RepairRepository>(
      () => RepairRepository(dataSource: injector.get<RepairDataSource>()),
    )
    ..registerFactory<SoftStartCubit>(SoftStartCubit.new)
    ..registerFactory<ReceivedSignalsCubit>(
      () => ReceivedSignalsCubit(
        repairRepository: injector.get<RepairRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
        remindersRepository: injector.get<RemindersRepository>(),
        syncService: injector.get<ReminderSyncService>(),
      ),
    )
    ..registerFactory<GuidedRepairCubit>(
      () => GuidedRepairCubit(
        repairRepository: injector.get<RepairRepository>(),
        remindersRepository: injector.get<RemindersRepository>(),
        syncService: injector.get<ReminderSyncService>(),
      ),
    )
    ..registerFactory<LearningCubit>(
      () => LearningCubit(repairRepository: injector.get<RepairRepository>()),
    )
    ..registerFactory<QuickRepairCubit>(
      () => QuickRepairCubit(repairRepository: injector.get<RepairRepository>()),
    )
    ..registerFactory<TemperatureCubit>(
      () => TemperatureCubit(repairRepository: injector.get<RepairRepository>()),
    );
}
