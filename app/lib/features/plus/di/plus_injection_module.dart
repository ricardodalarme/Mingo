import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/plus/data/data_sources/remote/plus_data_source.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/plus/presentation/manage/cubit/manage_plus_cubit.dart';
import 'package:app/features/plus/presentation/plans/cubit/plans_cubit.dart';
import 'package:app/features/plus/presentation/restore/cubit/restore_purchases_cubit.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';
import 'package:purchase_service/purchase_service.dart';

class PlusInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<PlusDataSource>(() => PlusDataSource(client: injector.get<GQLClient>()))
    ..registerLazySingleton<PlusRepository>(
      () => PlusRepository(
        dataSource: injector.get<PlusDataSource>(),
        purchaseService: injector.get<PurchaseService>(),
        authenticationRepository: injector.get<AuthenticationRepository>(),
      ),
    )
    ..registerFactory<PlansCubit>(() => PlansCubit(plusRepository: injector.get<PlusRepository>()))
    ..registerFactory<ManagePlusCubit>(
      () => ManagePlusCubit(plusRepository: injector.get<PlusRepository>()),
    )
    ..registerFactory<RestorePurchasesCubit>(
      () => RestorePurchasesCubit(plusRepository: injector.get<PlusRepository>()),
    );
}
