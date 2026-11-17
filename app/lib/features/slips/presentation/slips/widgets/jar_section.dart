import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/slips/data/models/drawn_slip.dart';
import 'package:app/features/slips/presentation/slips/cubit/jar_cubit.dart';
import 'package:app/features/slips/presentation/slips/cubit/slips_list_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The jar of good slips to open on a bad day: each draw shows one the person kept.
class const JarSection({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<JarCubit>()..draw(),
      child: const _JarContent(),
    );
  }
}

class const _JarContent() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final slip = context.select((JarCubit cubit) => cubit.state.slip);
    final cubit = context.read<JarCubit>();

    return switch (slip) {
      Success<DrawnSlip?>(:final value) when value == null => BaseEmptyState(
        title: l10n.jarEmptyTitle,
        text: l10n.jarEmpty,
        textMaxLines: null,
        actionText: l10n.jarEmptyAction,
        onAction: () => context.read<SlipsListCubit>().changeScope(SlipsScope.all),
      ),
      Success<DrawnSlip?>(:final value?) => _Drawn(slip: value),
      Failure(:final exception) => AppErrorView(exception: exception, onRetry: cubit.draw),
      _ => const Padding(
        padding: EdgeInsets.only(top: AppSpace.s24),
        child: Center(child: BaseLoadingDots()),
      ),
    };
  }
}

class const _Drawn({required final DrawnSlip slip}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final cubit = context.read<JarCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Reveal(
          key: ValueKey(slip.id),
          child: AppPressable(
            onTap: () => context.pushRoute(SlipDetailRoute(id: slip.id)),
            borderRadius: BorderRadius.circular(AppRadius.card),
            child: BaseSurfaceCard(
              style: .ring,
              padding: const EdgeInsets.all(AppSpace.s20),
              child: Semantics(
                liveRegion: true,
                child: Text(slip.body, style: context.text.titleLg),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpace.s8),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: BaseTextLink(text: l10n.jarAnother, onPressed: cubit.draw),
        ),
      ],
    );
  }
}
