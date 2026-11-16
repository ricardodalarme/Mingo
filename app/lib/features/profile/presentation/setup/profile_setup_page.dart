import 'package:app/features/onboarding/presentation/intro/cubit/intro_cubit.dart';
import 'package:app/features/profile/presentation/setup/cubit/profile_setup_cubit.dart';
import 'package:app/features/profile/presentation/widgets/pronoun_chips.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const ProfileSetupPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AppInjector.instance.get<ProfileSetupCubit>()..onThemeChanged(AppThemeScope.of(context)),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.profileSetup;

    return BaseView(
      appBar: const BaseAppBar(
        stepIndicator: BaseStepper(count: introStepCount, currentIndex: introStepCount - 1),
      ),
      body: BlocListener<ProfileSetupCubit, ProfileSetupState>(
        listenWhen: (previous, current) => previous.saveAction != current.saveAction,
        listener: _onSaveChanged,
        child: BaseStackedContent(
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
              const SizedBox(height: AppSpace.s28),
              const _NameField(),
              const SizedBox(height: AppSpace.s10),
              const _PronounsField(isPartner: false),
              const SizedBox(height: AppSpace.s18),
              const _PartnerNameField(),
              const SizedBox(height: AppSpace.s10),
              const _PronounsField(isPartner: true),
              const SizedBox(height: AppSpace.s14),
              const _DateField(),
              const SizedBox(height: AppSpace.s14),
              BaseNote(text: l10n.pronounsNote),
            ],
          ),
          footer: const _ContinueButton(),
        ),
      ),
    );
  }

  void _onSaveChanged(BuildContext context, ProfileSetupState state) {
    switch (state.saveAction) {
      case Success():
        context.pushRoute(const PartnerStepRoute());
      case Failure(:final exception):
        BaseToast.show(
          context,
          context.l10n.profileSetup.errors.selectOrFallback(exception.l10nKey),
        );
      default:
        break;
    }
  }
}

class const _NameField() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.profileSetup;
    final name = context.select((ProfileSetupCubit cubit) => cubit.state.name);

    return BaseTextField(
      text: name.value,
      label: l10n.nameLabel,
      hint: l10n.nameHint,
      errorText: l10n.nameErrors.selectOrNull(name.errorName),
      onChanged: context.read<ProfileSetupCubit>().onNameChanged,
    );
  }
}

class const _PartnerNameField() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.profileSetup;
    final partnerName = context.select((ProfileSetupCubit cubit) => cubit.state.partnerName);

    return BaseTextField(
      text: partnerName.value,
      label: l10n.partnerNameLabel,
      hint: l10n.partnerNameHint,
      errorText: l10n.partnerNameErrors.selectOrNull(partnerName.errorName),
      onChanged: context.read<ProfileSetupCubit>().onPartnerNameChanged,
    );
  }
}

class const _PronounsField({required final bool isPartner}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selected = context.select(
      (ProfileSetupCubit cubit) => isPartner ? cubit.state.partnerPronouns : cubit.state.pronouns,
    );
    final cubit = context.read<ProfileSetupCubit>();

    return PronounChips(
      selected: selected,
      onChanged: isPartner ? cubit.onPartnerPronounsChanged : cubit.onPronounsChanged,
    );
  }
}

class const _DateField() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.profileSetup;
    final date = context.select((ProfileSetupCubit cubit) => cubit.state.togetherSince);
    final showsError = context.select((ProfileSetupCubit cubit) => cubit.state.showsDateError);

    return BaseDateField(
      label: l10n.dateLabel,
      hint: l10n.dateHint,
      value: date,
      minimum: earliestTogetherSince,
      maximum: clock.now(),
      errorText: l10n.dateErrors.selectOrNull(showsError ? 'empty' : null),
      formatter: (value) =>
          l10n.dateFormat(day: value.day, month: l10n.months[value.month - 1], year: value.year),
      onChanged: context.read<ProfileSetupCubit>().onDateChanged,
    );
  }
}

class const _ContinueButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.profileSetup;
    final isLoading = context.select((ProfileSetupCubit cubit) => cubit.state.saveAction.isLoading);

    return BaseButton(
      text: l10n.continueButton,
      isLoading: isLoading,
      onPressed: context.read<ProfileSetupCubit>().save,
    );
  }
}
