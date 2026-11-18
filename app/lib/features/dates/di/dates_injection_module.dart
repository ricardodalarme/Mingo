import 'package:app/features/dates/data/data_sources/remote/dates_data_source.dart';
import 'package:app/features/dates/data/repositories/dates_repository.dart';
import 'package:app/features/dates/presentation/dates/cubit/dates_cubit.dart';
import 'package:app/features/home_widgets/data/repositories/home_widgets_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class DatesInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<DatesDataSource>(
      () => DatesDataSource(client: injector.get<GQLClient>()),
    )
    ..registerLazySingleton<DatesRepository>(
      () => DatesRepository(
        dataSource: injector.get<DatesDataSource>(),
        togetherRepository: injector.get<TogetherRepository>(),
        // Resolved when a date changes: the widgets read the distance, which reads the dates.
        onDatesChanged: () => injector.get<HomeWidgetsRepository>().syncQuietly(),
      ),
    )
    ..registerFactory<DatesCubit>(
      () => DatesCubit(
        datesRepository: injector.get<DatesRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
      ),
    );
}
