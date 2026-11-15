import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/authentication/presentation/sign_in/cubit/sign_in_cubit.dart';
import 'package:authentication_service/authentication_service.dart';
import 'package:core/core.dart';

class AuthenticationInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<AuthenticationService>(AuthenticationService.new)
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(authenticationService: injector.get<AuthenticationService>()),
    )
    ..registerFactory<SignInCubit>(
      () => SignInCubit(authenticationRepository: injector.get<AuthenticationRepository>()),
    );
}
