import 'package:app/features/_shared/chat_actions/chat_action_handler.dart';
import 'package:app/features/mood/chat/mood_chat_handlers.dart';
import 'package:app/features/mood/data/data_sources/local/mood_local_data_source.dart';
import 'package:app/features/mood/data/data_sources/remote/mood_data_source.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/mood/presentation/calendar/cubit/mood_calendar_cubit.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:preferences_service/preferences_service.dart';

class MoodInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) {
    injector
      ..registerLazySingleton<MoodDataSource>(
        () => MoodDataSource(client: injector.get<GQLClient>()),
      )
      ..registerLazySingleton<MoodLocalDataSource>(
        () => MoodLocalDataSource(preferencesService: injector.get<PreferencesService>()),
      )
      ..registerLazySingleton<MoodRepository>(
        () => MoodRepository(
          dataSource: injector.get<MoodDataSource>(),
          localDataSource: injector.get<MoodLocalDataSource>(),
        ),
      )
      ..registerFactory<MoodCubit>(
        () => MoodCubit(
          moodRepository: injector.get<MoodRepository>(),
          slipRepository: injector.get<SlipRepository>(),
        ),
      )
      ..registerFactory<MoodCalendarCubit>(
        () => MoodCalendarCubit(moodRepository: injector.get<MoodRepository>()),
      );

    injector.get<ChatActionRegistry>()
      ..register('log_mood', () => LogMoodChatHandler(repository: injector.get<MoodRepository>()))
      ..register(
        'share_mood',
        () => ShareMoodChatHandler(repository: injector.get<MoodRepository>()),
      );
  }
}
