import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/dev_menu/debug_sign_in/cubit/debug_sign_in_cubit.dart';
import 'package:core/core.dart';

class DevMenuInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerFactory<DebugSignInCubit>(
      () => DebugSignInCubit(authenticationRepository: injector.get<AuthenticationRepository>()),
    );
}
