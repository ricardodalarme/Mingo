import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/presentation/cards/cubit/spice_cards_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// One evening card at a time; the other person says yes or "not today", and a no is never explained.
@RoutePage()
class const SpiceCardsPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<SpiceCardsCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.cards;
    final card = context.select((SpiceCardsCubit cubit) => cubit.state.card);
    final isAnswered = context.select((SpiceCardsCubit cubit) => cubit.state.isAnswered);
    final cubit = context.read<SpiceCardsCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: BlocListener<SpiceCardsCubit, SpiceCardsState>(
        listenWhen: (previous, current) => previous.respondAction != current.respondAction,
        listener: (context, state) {
          if (state.respondAction case Failure(:final exception)) {
            BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
          }
        },
        child: SkeletonizerResourceWidget<SpiceCard?>(
          card,
          fakeValue: const SpiceCard(
            id: 'fake',
            text: 'Uma massagem de dez minutos',
            isMine: false,
          ),
          successBuilder: (value) {
            if (isAnswered) {
              return BaseStackedContent(
                body: BaseEmptyState(title: l10n.answeredTitle, text: l10n.answeredText),
                footer: BaseButton(text: l10n.next, onPressed: cubit.load),
              );
            }
            if (value == null) {
              return BaseStackedContent(
                body: BaseEmptyState(title: l10n.emptyTitle, text: l10n.emptyText),
              );
            }

            return _Card(card: value);
          },
          failureBuilder: (exception) => AppErrorView(exception: exception, onRetry: cubit.load),
        ),
      ),
    );
  }
}

class const _Card({required final SpiceCard card}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.cards;
    final isLoading = context.select(
      (SpiceCardsCubit cubit) => cubit.state.respondAction.isLoading,
    );
    final cubit = context.read<SpiceCardsCubit>();

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            card.isMine ? l10n.mineHint : l10n.theirsHint,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseSurfaceCard(
            style: .ring,
            padding: const EdgeInsets.all(AppSpace.s20),
            child: Text(card.text, style: context.text.titleLg),
          ),
        ],
      ),
      footer: card.isMine
          ? BaseButton(text: l10n.refresh, variant: .secondary, onPressed: cubit.load)
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BaseButton(
                  text: l10n.accept,
                  isLoading: isLoading,
                  onPressed: () => cubit.respond(accept: true),
                ),
                const SizedBox(height: AppSpace.s10),
                BaseButton(
                  text: l10n.notToday,
                  variant: .secondary,
                  onPressed: () => cubit.respond(accept: false),
                ),
              ],
            ),
    );
  }
}
