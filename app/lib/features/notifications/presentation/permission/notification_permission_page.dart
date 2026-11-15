import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/notifications/presentation/permission/cubit/notification_permission_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Explains the reminders before the system prompt; pops when the person has answered.
@RoutePage()
class const NotificationPermissionPage({super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<NotificationPermissionCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notificationPermission;
    final hasRegistrationFailed = context.select(
      (NotificationPermissionCubit cubit) => cubit.state.hasRegistrationFailed,
    );

    return BaseView(
      appBar: null,
      body: BlocListener<NotificationPermissionCubit, NotificationPermissionState>(
        listenWhen: (previous, current) =>
            previous.requestAction != current.requestAction ||
            previous.registrationAction != current.registrationAction,
        listener: (context, state) {
          switch (state.requestAction) {
            case Failure(:final exception):
              BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
              context.router.maybePop();
            case Success(value: final access)
                when access == NotificationAccess.denied || state.registrationAction is Success:
              context.router.maybePop();
            case Initial() || Loading() || Success():
              break;
          }
        },
        child: BaseStackedContent(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpace.s34),
              Text(
                l10n.label,
                style: context.text.label.copyWith(color: context.colors.accentLabel),
              ),
              const SizedBox(height: AppSpace.s8),
              Semantics(
                header: true,
                child: AppHighlightedText(
                  text: l10n.title,
                  highlight: l10n.titleHighlight,
                  style: context.text.display,
                ),
              ),
              const SizedBox(height: AppSpace.s24),
              for (final point in [l10n.pointLimit, l10n.pointPrivate, l10n.pointChoice]) ...[
                BaseSurfaceCard(child: Text(point, style: context.text.bodyLg)),
                const SizedBox(height: AppSpace.s10),
              ],
              const SizedBox(height: AppSpace.s6),
              BaseNote(text: l10n.changeLater),
            ],
          ),
          footer: hasRegistrationFailed
              ? const _RegistrationFailedActions()
              : const _PermissionActions(),
        ),
      ),
    );
  }
}

class const _PermissionActions() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notificationPermission;
    final isBusy = context.select((NotificationPermissionCubit cubit) => cubit.state.isBusy);

    return Row(
      children: [
        BaseButton(
          text: l10n.notNow,
          variant: .text,
          isFullWidth: false,
          onPressed: () => context.router.maybePop(),
        ),
        const SizedBox(width: AppSpace.s12),
        Expanded(
          child: BaseButton(
            text: l10n.allow,
            isLoading: isBusy,
            onPressed: context.read<NotificationPermissionCubit>().allow,
          ),
        ),
      ],
    );
  }
}

class const _RegistrationFailedActions() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notificationPermission;
    final isRegistering = context.select(
      (NotificationPermissionCubit cubit) => cubit.state.registrationAction.isLoading,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseNote(text: l10n.registrationFailed, icon: AppIcons.info),
        const SizedBox(height: AppSpace.s12),
        BaseButton(
          text: l10n.retryRegistration,
          isLoading: isRegistering,
          onPressed: context.read<NotificationPermissionCubit>().register,
        ),
        const SizedBox(height: AppSpace.s6),
        Center(
          child: BaseTextLink(
            text: l10n.continueWithoutReminders,
            onPressed: () => context.router.maybePop(),
          ),
        ),
      ],
    );
  }
}
