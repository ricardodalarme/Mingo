import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/widgets/mood_form.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const MoodPage({final String? initialMood, super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = AppInjector.instance.get<MoodCubit>();
        cubit.load().then((_) {
          final mood = MoodKind.values.asNameMap()[initialMood];
          if (mood != null && !cubit.isClosed) cubit.selectMood(mood);
        });

        return cubit;
      },
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.mood;
    final entry = context.select((MoodCubit cubit) => cubit.state.entry);
    final audience = context.select((MoodCubit cubit) => cubit.state.audience);
    final partnerName = context.select((MoodCubit cubit) => cubit.state.partnerName);
    final isChoosingShare = context.select((MoodCubit cubit) => cubit.state.isChoosingShare);
    final hasName = partnerName != null && partnerName.isNotEmpty;

    return BaseView(
      appBar: isChoosingShare
          ? BaseAppBar(onBack: context.read<MoodCubit>().back)
          : BaseAppBar(
              onClose: () => context.router.maybePop(),
              trailing: Text(switch (audience) {
                MoodShare.none => l10n.privateCue,
                MoodShare.mood || MoodShare.moodNeed =>
                  hasName ? l10n.sharedCue(name: partnerName) : l10n.sharedCueNoName,
              }, style: context.text.body.copyWith(color: context.colors.textSecondary)),
            ),
      body: BlocListener<MoodCubit, MoodState>(
        listenWhen: (previous, current) => previous.saveAction != current.saveAction,
        listener: _onSaveChanged,
        child: BlocListener<MoodCubit, MoodState>(
          listenWhen: (previous, current) => previous.needAction != current.needAction,
          listener: _onNeedChanged,
          child: switch (entry) {
            Failure() => AppErrorView(
              exception: entry.exception,
              onRetry: context.read<MoodCubit>().load,
            ),
            Loading() => const Center(child: BaseLoadingDots()),
            _ => const MoodForm(),
          },
        ),
      ),
    );
  }

  void _onNeedChanged(BuildContext context, MoodState state) {
    final action = state.needAction;
    final l10n = context.l10n.mood;
    if (action is Failure) {
      BaseToast.show(
        context,
        l10n.errors.selectOrFallback(action.exception.l10nKey),
        variant: BaseToastVariant.error,
      );

      return;
    }
    if (action is Success) BaseToast.show(context, l10n.needSaved);
  }

  void _onSaveChanged(BuildContext context, MoodState state) {
    final action = state.saveAction;
    final l10n = context.l10n.mood;
    if (action is Failure) {
      BaseToast.show(
        context,
        l10n.errors.selectOrFallback(action.exception.l10nKey),
        variant: BaseToastVariant.error,
      );

      return;
    }
    if (action is Success) {
      BaseToast.show(context, l10n.saved);
      context.router.maybePop();
    }
  }
}
