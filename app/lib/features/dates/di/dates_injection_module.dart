import 'package:app/features/dates/data/data_sources/remote/dates_data_source.dart';
import 'package:app/features/dates/data/repositories/dates_repository.dart';
import 'package:app/features/dates/presentation/dates/cubit/dates_cubit.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
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
        widgetsRepository: injector.get<WidgetsRepository>(),
      ),
    )
    ..registerFactory<DatesCubit>(
      () => DatesCubit(
        datesRepository: injector.get<DatesRepository>(),
        profileRepository: injector.get<ProfileRepository>(),
      ),
    );
}
