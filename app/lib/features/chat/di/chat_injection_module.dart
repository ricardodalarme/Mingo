import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/chat/data/data_sources/local/hard_conversation_local_data_source.dart';
import 'package:app/features/chat/data/data_sources/remote/chat_data_source.dart';
import 'package:app/features/chat/data/data_sources/remote/learned_items_data_source.dart';
import 'package:app/features/chat/data/repositories/chat_repository.dart';
import 'package:app/features/chat/data/repositories/hard_conversation_repository.dart';
import 'package:app/features/chat/data/repositories/learned_items_repository.dart';
import 'package:app/features/chat/presentation/chat/cubit/chat_cubit.dart';
import 'package:app/features/chat/presentation/hard_conversation/cubit/hard_conversation_cubit.dart';
import 'package:app/features/chat/presentation/learned/cubit/learned_items_cubit.dart';
import 'package:app/features/chat/presentation/settings/cubit/chat_settings_cubit.dart';
import 'package:app/features/notes/data/repositories/notes_repository.dart';
import 'package:app/features/partner/data/repositories/partner_repository.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/infrastructure/config/env_variables.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:preferences_service/preferences_service.dart';

class ChatInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<ChatDataSource>(
      () => ChatDataSource(
        client: injector.get<GQLClient>(),
        restClient: injector.get<RestClient>(),
        functionUrl: '${EnvVariables.functionsUrl}/chat',
      ),
    )
    ..registerLazySingleton<LearnedItemsDataSource>(
      () => LearnedItemsDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<LearnedItemsRepository>(
      () => LearnedItemsRepository(dataSource: injector.get<LearnedItemsDataSource>()),
    )
    ..registerLazySingleton<HardConversationLocalDataSource>(
      () => HardConversationLocalDataSource(preferencesService: injector.get<PreferencesService>()),
    )
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepository(
        dataSource: injector.get<ChatDataSource>(),
        profileRepository: injector.get<ProfileRepository>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
        slipRepository: injector.get<SlipRepository>(),
        plusRepository: injector.get<PlusRepository>(),
      ),
    )
    ..registerLazySingleton<HardConversationRepository>(
      () => HardConversationRepository(
        chatRepository: injector.get<ChatRepository>(),
        notesRepository: injector.get<NotesRepository>(),
        localDataSource: injector.get<HardConversationLocalDataSource>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<ChatCubit>(
      () => ChatCubit(
        chatRepository: injector.get<ChatRepository>(),
        learnedItemsRepository: injector.get<LearnedItemsRepository>(),
      ),
    )
    ..registerFactory<ChatSettingsCubit>(
      () => ChatSettingsCubit(chatRepository: injector.get<ChatRepository>()),
    )
    ..registerFactory<HardConversationCubit>(
      () => HardConversationCubit(
        repository: injector.get<HardConversationRepository>(),
        chatRepository: injector.get<ChatRepository>(),
      ),
    )
    ..registerFactory<LearnedItemsCubit>(
      () => LearnedItemsCubit(
        learnedItemsRepository: injector.get<LearnedItemsRepository>(),
        partnerRepository: injector.get<PartnerRepository>(),
      ),
    );
}
