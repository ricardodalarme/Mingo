import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/cycle/data/models/sensitive_day.dart';
import 'package:app/features/cycle/presentation/sensitive_days/cubit/sensitive_days_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formatters/formatters.dart';

/// Marks today as sensitive and shows the person's own marked days.
///
/// Nothing here is inferred or predicted, and nothing reaches the partner: the marks are the
/// person's own rows, and telling the partner is the separate heavy-day notice.
@RoutePage()
class const SensitiveDaysPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<SensitiveDaysCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.sensitiveDays;
    final days = context.select((SensitiveDaysCubit cubit) => cubit.state.days);

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: BlocListener<SensitiveDaysCubit, SensitiveDaysState>(
        listenWhen: (previous, current) => previous.toggleAction != current.toggleAction,
        listener: (context, state) {
          final action = state.toggleAction;
          if (action is Failure) {
            BaseToast.show(
              context,
              l10n.errors.selectOrFallback(action.exception.l10nKey),
              variant: BaseToastVariant.error,
            );
          }
        },
        child: SkeletonizerResourceWidget<SensitiveDays>(
          days,
          fakeValue: SensitiveDays.fake(),
          successBuilder: (value) => _SensitiveDaysBody(value: value),
          failureBuilder: (failure) =>
              AppErrorView(exception: failure, onRetry: context.read<SensitiveDaysCubit>().load),
        ),
      ),
    );
  }
}

class const _SensitiveDaysBody({required final SensitiveDays value}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.sensitiveDays;
    final cubit = context.read<SensitiveDaysCubit>();
    final isMarked = value.isTodayMarked;

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.subtitle,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseListGroup(
            children: [
              BaseListTile(
                title: l10n.todayTitle,
                subtitle: isMarked ? l10n.todayOn : l10n.todayOff,
                icon: AppIcons.sun,
                control: BaseSwitch(
                  value: isMarked,
                  semanticLabel: l10n.todayTitle,
                  onChanged: (_) => cubit.toggleToday(),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.s24),
          BaseSectionHeader(title: l10n.calendarTitle),
          const SizedBox(height: AppSpace.s8),
          BaseCalendarGrid(
            month: value.today,
            today: value.today,
            milestones: value.markedDays,
            daySemanticLabel: (day) => value.isMarked(day)
                ? l10n.markedDay(day: DateFormatters.mediumDate(day))
                : DateFormatters.mediumDate(day),
          ),
          const SizedBox(height: AppSpace.s12),
          BaseNote(text: l10n.calendarNote),
        ],
      ),
    );
  }
}
