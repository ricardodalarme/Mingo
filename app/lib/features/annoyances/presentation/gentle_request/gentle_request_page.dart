import 'package:app/features/annoyances/presentation/gentle_request/cubit/gentle_request_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const GentleRequestPage({final String? annoyanceId, super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<GentleRequestCubit>()..start(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gentleRequest;

    return BaseView(
      appBar: BaseAppBar(onBack: () => context.router.maybePop()),
      body: BlocListener<GentleRequestCubit, GentleRequestState>(
        listenWhen: (previous, current) => previous.sendAction != current.sendAction,
        listener: _onSendChanged,
        child: BaseStackedContent(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                header: true,
                child: AppHighlightedText(
                  text: l10n.title,
                  highlight: l10n.titleHighlight,
                  style: context.text.titleXl,
                ),
              ),
              const SizedBox(height: AppSpace.s16),
              const _Field(kind: _FieldKind.when),
              const SizedBox(height: AppSpace.s12),
              const _Field(kind: _FieldKind.feel),
              const SizedBox(height: AppSpace.s12),
              const _Field(kind: _FieldKind.wish),
              const SizedBox(height: AppSpace.s16),
              const _Preview(),
              const SizedBox(height: AppSpace.s12),
              BaseNote(text: l10n.note, icon: AppIcons.clock),
            ],
          ),
          footer: Row(
            spacing: AppSpace.s10,
            children: [
              BaseButton(
                text: l10n.keep,
                variant: .secondary,
                isFullWidth: false,
                onPressed: () => context.router.maybePop(),
              ),
              Expanded(child: _SendButton(annoyanceId: annoyanceId)),
            ],
          ),
        ),
      ),
    );
  }

  void _onSendChanged(BuildContext context, GentleRequestState state) {
    final l10n = context.l10n.gentleRequest;
    switch (state.sendAction) {
      case Success():
        BaseToast.show(context, l10n.sent);
        context.router.maybePop();
      case Failure(:final exception):
        BaseToast.show(
          context,
          l10n.errors.selectOrFallback(exception.l10nKey),
          variant: BaseToastVariant.error,
        );
      default:
        break;
    }
  }
}

enum _FieldKind() {
  when,
  feel,
  wish,
}

class const _Field({required final _FieldKind kind}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gentleRequest;
    final cubit = context.read<GentleRequestCubit>();
    final input = context.select(
      (GentleRequestCubit cubit) => switch (kind) {
        _FieldKind.when => cubit.state.whenText,
        _FieldKind.feel => cubit.state.feelText,
        _FieldKind.wish => cubit.state.wishText,
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseSectionHeader(
          title: switch (kind) {
            _FieldKind.when => l10n.whenLabel,
            _FieldKind.feel => l10n.feelLabel,
            _FieldKind.wish => l10n.wishLabel,
          },
          isLabel: true,
        ),
        const SizedBox(height: AppSpace.s8),
        BaseTextField(
          text: input.value,
          hint: switch (kind) {
            _FieldKind.when => l10n.whenHint,
            _FieldKind.feel => l10n.feelHint,
            _FieldKind.wish => l10n.wishHint,
          },
          errorText: l10n.fieldErrors.selectOrNull(input.errorName),
          onChanged: switch (kind) {
            _FieldKind.when => cubit.onWhenChanged,
            _FieldKind.feel => cubit.onFeelChanged,
            _FieldKind.wish => cubit.onWishChanged,
          },
        ),
      ],
    );
  }
}

class const _Preview() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gentleRequest;
    final state = context.select((GentleRequestCubit cubit) => cubit.state);
    final name = state.partnerName;
    final sentence = state.isComplete
        ? l10n.sentence(
            when: state.whenText.value.trim(),
            feel: state.feelText.value.trim(),
            wish: state.wishText.value.trim(),
          )
        : l10n.previewEmpty;

    return BaseSurfaceCard(
      supportText: name == null ? l10n.previewTitleNoName : l10n.previewTitle(name: name),
      child: Text(sentence, style: context.text.bodyLg),
    );
  }
}

class const _SendButton({required final String? annoyanceId}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gentleRequest;
    final isLoading = context.select(
      (GentleRequestCubit cubit) => cubit.state.sendAction.isLoading,
    );

    return BaseButton(
      text: l10n.sendNow,
      isLoading: isLoading,
      onPressed: () async {
        final cubit = context.read<GentleRequestCubit>();
        if (!cubit.state.isComplete) return cubit.send(annoyanceId: annoyanceId);
        final confirmed = await BaseConfirmSheet.show(
          context: context,
          title: l10n.confirmTitle,
          text: l10n.confirmText,
          confirmText: l10n.sendNow,
        );
        if (confirmed) await cubit.send(annoyanceId: annoyanceId);
      },
    );
  }
}
