import 'package:app/features/chat/presentation/settings/cubit/chat_settings_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Today's usage and what the conversation sends to the model.
@RoutePage()
class const ChatSettingsPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<ChatSettingsCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.chat;
    final status = context.select((ChatSettingsCubit cubit) => cubit.state.status);
    final messagesLeft = context.select((ChatSettingsCubit cubit) => cubit.state.messagesLeft);
    final limit = context.select((ChatSettingsCubit cubit) => cubit.state.limit);
    final hasPlus = context.select((ChatSettingsCubit cubit) => cubit.state.hasPlus);
    final cubit = context.read<ChatSettingsCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.settingsTitle),
      body: switch (status) {
        Success() => BaseStackedContent(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                hasPlus ? l10n.planPlus : l10n.planFree,
                style: context.text.label.copyWith(color: context.colors.textSecondary),
              ),
              const SizedBox(height: AppSpace.s4),
              if (hasPlus && limit > 0)
                BaseMeter(
                  value: limit - messagesLeft,
                  max: limit,
                  label: l10n.usagePlus(left: messagesLeft, limit: limit),
                )
              else
                Text(
                  hasPlus ? l10n.usagePlus(left: messagesLeft, limit: limit) : l10n.usageFree,
                  style: context.text.bodySm.copyWith(color: context.colors.textSecondary),
                ),
              const SizedBox(height: AppSpace.s20),
              Semantics(header: true, child: Text(l10n.sendingTitle, style: context.text.titleXs)),
              const SizedBox(height: AppSpace.s8),
              Text(
                l10n.sendingText,
                style: context.text.body.copyWith(color: context.colors.textSecondary),
              ),
              const SizedBox(height: AppSpace.s20),
              BaseSectionHeader(title: l10n.remembersTitle),
              const SizedBox(height: AppSpace.s8),
              BaseListGroup(
                children: [
                  BaseListTile(
                    icon: AppIcons.book,
                    title: l10n.remembersAction,
                    subtitle: l10n.remembersText,
                    subtitleMaxLines: 3,
                    showsChevron: true,
                    onTap: () => context.pushRoute(const LearnedItemsRoute()),
                  ),
                ],
              ),
            ],
          ),
        ),
        Failure() => BaseEmptyState(
          title: l10n.errorTitle,
          text: l10n.errorText,
          actionText: context.l10n.common.retry,
          onAction: cubit.load,
        ),
        _ => const Center(child: BaseLoadingDots()),
      },
    );
  }
}
