import 'package:app/features/onboarding/presentation/intro/cubit/intro_cubit.dart';
import 'package:app/features/onboarding/presentation/intro/widgets/intro_scaffold.dart';
import 'package:app/features/profile/presentation/widgets/theme_option_selector.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const IntroThemePage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<IntroCubit>()..start(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.intro.theme;
    final cubit = context.read<IntroCubit>();

    Future<void> next(Future<void> Function() save) async {
      await save();
      if (context.mounted) await context.pushRoute(const FirstSlipRoute());
    }

    return IntroScaffold(
      stepIndex: 2,
      title: l10n.title,
      highlight: l10n.titleHighlight,
      subtitle: l10n.subtitle,
      body: const _ThemeOptions(),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.footnote,
            style: context.text.caption.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s12),
          IntroFooter(
            skipText: context.l10n.intro.skip,
            continueText: context.l10n.intro.continueButton,
            onSkip: () => next(() => cubit.skip(3)),
            onContinue: () => next(() => cubit.complete(3)),
          ),
        ],
      ),
    );
  }
}

class const _ThemeOptions() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selected = context.select((IntroCubit cubit) => cubit.state.theme);

    return ThemeOptionSelector(
      selected: selected,
      onChanged: (variant) {
        context.read<IntroCubit>().selectTheme(variant);
        AppThemeScope.set(context, variant);
      },
    );
  }
}
