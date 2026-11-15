import 'package:app/features/onboarding/presentation/first_slip/cubit/first_slip_cubit.dart';
import 'package:app/features/onboarding/presentation/intro/cubit/intro_cubit.dart';
import 'package:app/features/settings/data/repositories/settings_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:core/core.dart';

class OnboardingInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerFactory<IntroCubit>(
      () => IntroCubit(settingsRepository: injector.get<SettingsRepository>()),
    )
    ..registerFactory<FirstSlipCubit>(
      () => FirstSlipCubit(
        slipRepository: injector.get<SlipRepository>(),
        settingsRepository: injector.get<SettingsRepository>(),
      ),
    );
}
