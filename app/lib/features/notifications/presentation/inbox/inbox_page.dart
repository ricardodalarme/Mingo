import 'package:app/features/notifications/data/models/inbox_item.dart';
import 'package:app/features/notifications/presentation/inbox/cubit/inbox_cubit.dart';
import 'package:app/features/notifications/presentation/inbox/widgets/inbox_section.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const InboxPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => AppInjector.instance.get<InboxCubit>()..load(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.inbox;
    final items = context.select((InboxCubit cubit) => cubit.state.items);
    final partnerName = context.select((InboxCubit cubit) => cubit.state.partnerName);

    return BaseView(
      appBar: BaseAppBar(
        title: l10n.title,
        onBack: () => context.router.maybePop(),
        trailing: BaseRoundButton(
          icon: AppIcons.settings,
          semanticLabel: l10n.settingsAction,
          onPressed: () => context.pushRoute(const NotificationPreferencesRoute()),
        ),
      ),
      body: BlocListener<InboxCubit, InboxState>(
        listenWhen: (previous, current) => previous.markAction != current.markAction,
        listener: (context, state) {
          if (state.markAction case Failure(:final exception)) {
            BaseToast.show(
              context,
              l10n.errors.selectOrFallback(exception.l10nKey),
              variant: BaseToastVariant.error,
            );
          }
        },
        child: BaseRefreshable(
          onRefresh: context.read<InboxCubit>().load,
          child: SkeletonizerResourceWidget<List<InboxItem>>(
            items,
            fakeValue: [InboxItem.fake(), InboxItem.fake(), InboxItem.fake()],
            successBuilder: (value) => value.isEmpty
                ? BaseEmptyState(
                    title: l10n.emptyTitle,
                    text: l10n.emptyText,
                    actionText: l10n.settingsAction,
                    onAction: () => context.pushRoute(const NotificationPreferencesRoute()),
                    isSecondaryAction: true,
                  )
                : _InboxList(items: value, partnerName: partnerName),
            failureBuilder: (failure) => BaseEmptyState(
              title: l10n.errorTitle,
              text: l10n.errors.selectOrFallback(failure.l10nKey),
              face: FaceKind.sad,
              actionText: context.l10n.common.retry,
              onAction: context.read<InboxCubit>().load,
            ),
          ),
        ),
      ),
    );
  }
}

class const _InboxList({required final List<InboxItem> items, required final String? partnerName})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.inbox;
    final now = clock.now();
    bool isToday(InboxItem item) {
      final day = item.createdAt.toLocal();

      return day.year == now.year && day.month == now.month && day.day == now.day;
    }

    final today = [
      for (final item in items)
        if (isToday(item)) item,
    ];
    final earlier = [
      for (final item in items)
        if (!isToday(item)) item,
    ];
    final hasUnread = items.any((item) => !item.isRead);

    String timeLabel(InboxItem item) {
      final time = item.createdAt.toLocal();
      if (isToday(item)) {
        return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      }

      return context.l10n.today.weekdays[time.weekday - 1].substring(0, 3).toLowerCase();
    }

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (today.isNotEmpty) ...[
            InboxSection(
              title: l10n.todayTitle,
              items: today,
              partnerName: partnerName,
              timeLabel: timeLabel,
              actionLabel: hasUnread ? l10n.markAllRead : null,
              onAction: hasUnread ? context.read<InboxCubit>().markAllRead : null,
            ),
            const SizedBox(height: AppSpace.s24),
          ],
          if (earlier.isNotEmpty) ...[
            InboxSection(
              title: l10n.earlierTitle,
              items: earlier,
              partnerName: partnerName,
              timeLabel: timeLabel,
              actionLabel: today.isEmpty && hasUnread ? l10n.markAllRead : null,
              onAction: today.isEmpty && hasUnread ? context.read<InboxCubit>().markAllRead : null,
            ),
            const SizedBox(height: AppSpace.s16),
          ],
          BaseNote(text: l10n.footnote, icon: AppIcons.info),
        ],
      ),
    );
  }
}
