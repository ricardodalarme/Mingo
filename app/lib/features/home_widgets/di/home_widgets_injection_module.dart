import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/distance/data/repositories/distance_repository.dart';
import 'package:app/features/home_widgets/data/data_sources/local/home_widgets_local_data_source.dart';
import 'package:app/features/home_widgets/data/data_sources/remote/home_widgets_data_source.dart';
import 'package:app/features/home_widgets/data/repositories/home_widgets_repository.dart';
import 'package:app/features/home_widgets/data/services/home_widget_data_service.dart';
import 'package:app/features/home_widgets/presentation/gallery/cubit/home_widgets_gallery_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:preferences_service/preferences_service.dart';

class HomeWidgetsInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) {
    injector
      ..registerLazySingleton<HomeWidgetDataService>(HomeWidgetDataService.new)
      ..registerLazySingleton<HomeWidgetsLocalDataSource>(
        () => HomeWidgetsLocalDataSource(preferencesService: injector.get<PreferencesService>()),
      )
      ..registerLazySingleton<HomeWidgetsDataSource>(
        () => HomeWidgetsDataSource(client: injector.get<GQLClient>()),
      )
      ..registerLazySingleton<HomeWidgetsRepository>(
        () => HomeWidgetsRepository(
          dataSource: injector.get<HomeWidgetsDataSource>(),
          localDataSource: injector.get<HomeWidgetsLocalDataSource>(),
          homeWidgetDataService: injector.get<HomeWidgetDataService>(),
          authenticationRepository: injector.get<AuthenticationRepository>(),
          distanceRepository: injector.get<DistanceRepository>(),
        ),
      )
      ..registerFactory<HomeWidgetsGalleryCubit>(
        () => HomeWidgetsGalleryCubit(repository: injector.get<HomeWidgetsRepository>()),
      );
  }
}
