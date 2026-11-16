import 'package:app/features/onboarding/presentation/intro/cubit/intro_cubit.dart';
import 'package:app/features/onboarding/presentation/intro/widgets/intro_scaffold.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const IntroPhasePage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<IntroCubit>()..start(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.intro.phase;
    final cubit = context.read<IntroCubit>();

    Future<void> next(Future<void> Function() save) async {
      await save();
      if (context.mounted) await context.pushRoute(const IntroGoalsRoute());
    }

    return IntroScaffold(
      stepIndex: 0,
      isFirst: true,
      title: l10n.title,
      highlight: l10n.titleHighlight,
      subtitle: l10n.subtitle,
      body: const _PhaseOptions(),
      footer: IntroContinueFooter(
        text: context.l10n.intro.continueButton,
        onPressed: () => next(() => cubit.complete(1)),
      ),
    );
  }
}

class const _PhaseOptions() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = context.l10n.intro.phase.options;
    final selected = context.select((IntroCubit cubit) => cubit.state.phase);

    return Column(
      children: [
        for (final phase in introPhases) ...[
          BaseOptionTile(
            title: labels.selectOrFallback(phase.name),
            isSelected: selected == phase,
            onTap: () => context.read<IntroCubit>().selectPhase(phase),
          ),
          const SizedBox(height: AppSpace.s10),
        ],
      ],
    );
  }
}
