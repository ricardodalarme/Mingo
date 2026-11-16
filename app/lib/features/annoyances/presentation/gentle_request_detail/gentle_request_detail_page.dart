import 'package:app/features/annoyances/data/models/gentle_request.dart';
import 'package:app/features/annoyances/data/models/gentle_response.dart';
import 'package:app/features/annoyances/presentation/gentle_request_detail/cubit/gentle_request_detail_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const GentleRequestDetailPage({required final String id, super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<GentleRequestDetailCubit>()..load(id),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gentleRequestDetail;
    final request = context.select((GentleRequestDetailCubit cubit) => cubit.state.request);

    return BaseView(
      appBar: BaseAppBar(onBack: () => context.router.maybePop()),
      body: BlocListener<GentleRequestDetailCubit, GentleRequestDetailState>(
        listenWhen: (previous, current) => previous.action != current.action,
        listener: (context, state) {
          if (state.action case Failure(:final exception)) {
            BaseToast.show(
              context,
              l10n.errors.selectOrFallback(exception.l10nKey),
              variant: BaseToastVariant.error,
            );
          }
        },
        child: SkeletonizerResourceWidget<GentleRequest?>(
          request,
          fakeValue: GentleRequest(
            id: 'fake',
            whenText: 'chego e a casa está bagunçada',
            feelText: 'sozinha com as tarefas',
            wishText: 'dividir a tarde de sábado com você',
            senderId: 'a',
            recipientId: 'b',
            createdAt: DateTime(2026),
          ),
          successBuilder: (value) => value == null ? const _Gone() : _Detail(request: value),
          failureBuilder: (failure) => BaseEmptyState(
            title: l10n.errorTitle,
            text: l10n.errors.selectOrFallback(failure.l10nKey),
            actionText: context.l10n.common.retry,
            onAction: () => context.read<GentleRequestDetailCubit>().load(id),
          ),
        ),
      ),
    );
  }
}

class const _Gone() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gentleRequestDetail;

    return BaseEmptyState(
      title: l10n.goneTitle,
      text: l10n.goneText,
      actionText: context.l10n.annoyanceCheck.close,
      onAction: () => context.router.maybePop(),
    );
  }
}

class const _Detail({required final GentleRequest request}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gentleRequestDetail;
    final isSender = context.select((GentleRequestDetailCubit cubit) => cubit.state.isSender);
    final isBusy = context.select((GentleRequestDetailCubit cubit) => cubit.state.action.isLoading);
    final cubit = context.read<GentleRequestDetailCubit>();
    final other = (isSender ? request.recipientName : request.senderName) ?? l10n.partnerFallback;
    final sentence = context.l10n.gentleRequest.sentence(
      when: request.whenText,
      feel: request.feelText,
      wish: request.wishText,
    );

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: context.l10n.gentleRequest.title,
              highlight: context.l10n.gentleRequest.titleHighlight,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            isSender ? l10n.fromYou(name: other) : l10n.toYou(name: other),
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s16),
          BaseSurfaceCard(child: Text(sentence, style: context.text.bodyLg)),
          const SizedBox(height: AppSpace.s16),
          if (!isSender && !request.isAnswered) ...[
            BaseSectionHeader(title: l10n.answerTitle),
            const SizedBox(height: AppSpace.s10),
            for (final response in GentleResponse.values) ...[
              BaseOptionTile(
                title: l10n.responses.selectOrFallback(response.name),
                onTap: isBusy ? null : () => cubit.respond(response),
              ),
              const SizedBox(height: AppSpace.s10),
            ],
          ] else if (request.response case final response?)
            BaseNote(
              text: isSender
                  ? l10n.answeredBy(
                      name: other,
                      answer: l10n.responses.selectOrFallback(response.name),
                    )
                  : l10n.youAnswered(answer: l10n.responses.selectOrFallback(response.name)),
              icon: AppIcons.check,
            )
          else
            BaseNote(text: l10n.waiting, icon: AppIcons.clock),
          if (isSender && request.thankedAt != null) ...[
            const SizedBox(height: AppSpace.s10),
            BaseNote(text: l10n.thanked, icon: AppIcons.heart),
          ],
        ],
      ),
      footer: isSender && request.canBeThanked
          ? BaseButton(
              text: l10n.thankAction,
              isLoading: isBusy,
              onPressed: () => cubit.thank(l10n.thankBody(name: other, wish: request.wishText)),
            )
          : null,
    );
  }
}
