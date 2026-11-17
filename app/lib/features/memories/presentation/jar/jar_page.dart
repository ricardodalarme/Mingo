import 'package:app/features/memories/data/models/drawn_slip.dart';
import 'package:app/features/memories/presentation/jar/cubit/jar_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The jar of good slips to open on a bad day: each draw shows one the person kept.
@RoutePage()
class const JarPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => AppInjector.instance.get<JarCubit>()..draw(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.memories;
    final slip = context.select((JarCubit cubit) => cubit.state.slip);
    final cubit = context.read<JarCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.segmentJar),
      body: BaseStackedContent(
        body: switch (slip) {
          Success<DrawnSlip?>(:final value) when value == null => BaseEmptyState(
            title: l10n.jarEmptyTitle,
            text: l10n.jarEmpty,
            textMaxLines: null,
            actionText: l10n.jarEmptyAction,
            onAction: () => context.router.root.navigate(const HomeRoute(children: [SlipsRoute()])),
          ),
          Success<DrawnSlip?>(:final value?) => _Drawn(slip: value),
          Failure() => BaseEmptyState(
            title: l10n.errorTitle,
            text: l10n.errorText,
            actionText: context.l10n.common.retry,
            onAction: cubit.draw,
          ),
          _ => const Padding(
            padding: EdgeInsets.only(top: AppSpace.s24),
            child: Center(child: BaseLoadingDots()),
          ),
        },
      ),
    );
  }
}

class const _Drawn({required final DrawnSlip slip}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.memories;
    final cubit = context.read<JarCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpace.s12),
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
        Row(
          children: [
            BaseTextLink(text: l10n.jarAnother, onPressed: cubit.draw),
            const Spacer(),
            BaseTextLink(text: l10n.jarClose, onPressed: () => context.router.maybePop()),
          ],
        ),
      ],
    );
  }
}
