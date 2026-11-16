import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/onboarding/presentation/intro/cubit/intro_cubit.dart';
import 'package:app/features/onboarding/presentation/partner/cubit/partner_step_cubit.dart';
import 'package:app/features/onboarding/presentation/partner/widgets/why_invite_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const PartnerStepPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => AppInjector.instance.get<PartnerStepCubit>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.partnerStep;
    final choice = context.select((PartnerStepCubit cubit) => cubit.state);
    final cubit = context.read<PartnerStepCubit>();

    Future<void> next() async {
      await cubit.save();
      if (!context.mounted) return;
      if (choice == PartnerChoice.invite) await context.pushRoute(const InviteRoute());
      if (context.mounted) await context.pushRoute(const NotificationPermissionRoute());
      if (context.mounted) context.read<AppCubit>().completeOnboarding();
    }

    return BaseView(
      appBar: const BaseAppBar(
        stepIndicator: BaseStepper(count: introStepCount, currentIndex: introStepCount - 1),
      ),
      body: BaseStackedContent(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpace.s12),
            Semantics(
              header: true,
              child: AppHighlightedText(
                text: l10n.title,
                highlight: l10n.titleHighlight,
                style: context.text.titleXl,
              ),
            ),
            const SizedBox(height: AppSpace.s8),
            Text(
              l10n.subtitle,
              style: context.text.body.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpace.s24),
            BaseOptionTile(
              title: l10n.inviteTitle,
              support: l10n.inviteSupport,
              isSelected: choice == PartnerChoice.invite,
              onTap: () => cubit.choose(PartnerChoice.invite),
            ),
            const SizedBox(height: AppSpace.s10),
            BaseOptionTile(
              title: l10n.aloneTitle,
              support: l10n.aloneSupport,
              isSelected: choice == PartnerChoice.later,
              onTap: () => cubit.choose(PartnerChoice.later),
            ),
            const SizedBox(height: AppSpace.s10),
            BaseOptionTile(
              title: l10n.soloOnlyTitle,
              support: l10n.soloOnlySupport,
              isSelected: choice == PartnerChoice.soloOnly,
              onTap: () => cubit.choose(PartnerChoice.soloOnly),
            ),
            const SizedBox(height: AppSpace.s12),
            Align(
              alignment: Alignment.centerLeft,
              child: BaseTextLink(
                text: l10n.haveCode,
                onPressed: () => context.pushRoute(AcceptInviteRoute()),
              ),
            ),
          ],
        ),
        footer: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BaseButton(text: l10n.continueButton, onPressed: next),
            BaseTextLink(text: l10n.whyInvite, onPressed: () => showWhyInviteSheet(context)),
          ],
        ),
      ),
    );
  }
}
