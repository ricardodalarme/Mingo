import 'package:app/features/heavy_day/presentation/heavy_day/cubit/heavy_day_cubit.dart';
import 'package:app/features/notes/data/repositories/notes_repository.dart';
import 'package:app/features/privacy/data/repositories/privacy_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';

class HeavyDayInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) =>
      injector..registerFactory<HeavyDayCubit>(
        () => HeavyDayCubit(
          privacyRepository: injector.get<PrivacyRepository>(),
          profileRepository: injector.get<ProfileRepository>(),
          notesRepository: injector.get<NotesRepository>(),
        ),
      );
}
