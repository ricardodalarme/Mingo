import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/privacy/data/repositories/privacy_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/programs/data/data_sources/remote/programs_data_source.dart';
import 'package:app/features/programs/data/repositories/programs_repository.dart';
import 'package:app/features/programs/presentation/diary/cubit/diary_cubit.dart';
import 'package:app/features/programs/presentation/lesson/cubit/lesson_cubit.dart';
import 'package:app/features/programs/presentation/program_detail/cubit/program_detail_cubit.dart';
import 'package:app/features/programs/presentation/programs/cubit/programs_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class ProgramsInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<ProgramsDataSource>(
      () => ProgramsDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<ProgramsRepository>(
      () => ProgramsRepository(
        dataSource: injector.get<ProgramsDataSource>(),
        profileRepository: injector.get<ProfileRepository>(),
      ),
    )
    ..registerFactory<ProgramsCubit>(
      () => ProgramsCubit(
        programsRepository: injector.get<ProgramsRepository>(),
        plusRepository: injector.get<PlusRepository>(),
      ),
    )
    ..registerFactory<ProgramDetailCubit>(
      () => ProgramDetailCubit(
        programsRepository: injector.get<ProgramsRepository>(),
        plusRepository: injector.get<PlusRepository>(),
        privacyRepository: injector.get<PrivacyRepository>(),
      ),
    )
    ..registerFactory<LessonCubit>(
      () => LessonCubit(
        programsRepository: injector.get<ProgramsRepository>(),
        plusRepository: injector.get<PlusRepository>(),
        privacyRepository: injector.get<PrivacyRepository>(),
      ),
    )
    ..registerFactory<DiaryCubit>(
      () => DiaryCubit(programsRepository: injector.get<ProgramsRepository>()),
    );
}
