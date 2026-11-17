import 'package:app/features/app/presentation/connectivity/cubit/connectivity_cubit.dart';
import 'package:app/features/chat/data/models/chat_models.dart';
import 'package:app/features/chat/presentation/chat/cubit/chat_cubit.dart';
import 'package:app/features/chat/presentation/save_learning/save_learning_sheet.dart';
import 'package:app/features/plus/presentation/lock/plus_lock.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A calm chat with the mascot; nothing said here is stored.
@RoutePage()
class const ChatPage({final ChatMode mode = ChatMode.free, super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<ChatCubit>()
        ..setMode(mode)
        ..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.chat;
    final stage = context.select((ChatCubit cubit) => cubit.state.stage);
    final cubit = context.read<ChatCubit>();

    return BaseView(
      appBar: BaseAppBar(
        titleWidget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox.square(
              dimension: 34,
              child: FittedBox(
                child: BaseFace(kind: FaceKind.smile, size: FaceSize.small),
              ),
            ),
            const SizedBox(width: AppSpace.s8),
            Text(
              l10n.title,
              style: context.text.titleXs.copyWith(color: context.colors.textPrimary),
            ),
          ],
        ),
        trailing: BaseRoundButton(
          icon: AppIcons.more,
          semanticLabel: l10n.menuLabel,
          onPressed: () => _openMenu(context, cubit),
        ),
      ),
      body: BlocListener<ChatCubit, ChatState>(
        listenWhen: (previous, current) =>
            previous.saveAction != current.saveAction ||
            previous.saveLearningAction != current.saveLearningAction,
        listener: (context, state) {
          final failure = switch ((state.saveAction, state.saveLearningAction)) {
            (Failure(:final exception), _) || (_, Failure(:final exception)) => exception,
            _ => null,
          };
          if (failure != null) {
            BaseToast.show(context, l10n.errors.selectOrFallback(failure.l10nKey));
          } else if (state.saveLearningAction is Success) {
            BaseToast.show(context, l10n.learningSaved);
          } else if (state.saveAction is Success) {
            BaseToast.show(context, l10n.slipSaved);
          }
        },
        child: switch (stage) {
          Loading() || Initial() => const Center(child: BaseLoadingDots()),
          Failure() => BaseEmptyState(
            title: l10n.errorTitle,
            text: l10n.errorText,
            actionText: context.l10n.common.retry,
            onAction: cubit.load,
          ),
          Success(:final value) => switch (value) {
            ChatStage.unavailable => BaseEmptyState(
              title: l10n.unavailableTitle,
              text: l10n.unavailableText,
            ),
            ChatStage.ready || ChatStage.limitReached => _Conversation(
              isLimitReached: value == ChatStage.limitReached,
            ),
          },
        },
      ),
    );
  }
}

enum _ChatMenuAction() {
  learned,
  settings,
}

Future<void> _openMenu(BuildContext context, ChatCubit cubit) async {
  final l10n = context.l10n.chat;

  final action = await BaseSheet.show<_ChatMenuAction>(
    context: context,
    title: l10n.title,
    child: BaseListGroup(
      children: [
        BaseListTile(
          title: l10n.learnedLink,
          icon: AppIcons.book,
          showsChevron: true,
          onTap: () => Navigator.pop(context, _ChatMenuAction.learned),
        ),
        BaseListTile(
          title: l10n.settingsTitle,
          icon: AppIcons.settings,
          showsChevron: true,
          onTap: () => Navigator.pop(context, _ChatMenuAction.settings),
        ),
      ],
    ),
  );
  if (!context.mounted) return;

  switch (action) {
    case _ChatMenuAction.learned:
      await context.pushRoute(const LearnedItemsRoute());
    case _ChatMenuAction.settings:
      await context.pushRoute(const ChatSettingsRoute());
    case null:
      return;
  }
}

class const _Conversation({required final bool isLimitReached}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.chat;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.screenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpace.s8),
          const Expanded(child: _MessageList()),
          const SizedBox(height: AppSpace.s12),
          if (isLimitReached)
            PlusLock(title: l10n.limitTitle, text: l10n.limitText)
          else
            const _Composer(),
          const SizedBox(height: AppSpace.s12),
        ],
      ),
    );
  }
}

class const _MessageList() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.chat;
    final messages = context.select((ChatCubit cubit) => cubit.state.messages);
    final options = context.select((ChatCubit cubit) => cubit.state.options);
    final cubit = context.read<ChatCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: messages.isEmpty
              ? const _Entry()
              : ListView.separated(
                  reverse: true,
                  itemCount: messages.length,
                  separatorBuilder: (_, _) => const SizedBox(height: AppSpace.s8),
                  itemBuilder: (context, index) =>
                      _Message(message: messages[messages.length - 1 - index]),
                ),
        ),
        if (messages.isEmpty && options.isEmpty) ...[
          const SizedBox(height: AppSpace.s8),
          Text(
            l10n.startHere,
            style: context.text.caption.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s8),
          Wrap(
            spacing: AppSpace.s8,
            runSpacing: AppSpace.s8,
            children: [
              for (final starter in [
                l10n.starterBothered,
                l10n.starterThanks,
                l10n.starterDate,
                l10n.starterTalk,
              ])
                BaseChoiceChip(label: starter, onTap: () => cubit.send(starter)),
            ],
          ),
        ],
        if (options.isNotEmpty) ...[
          const SizedBox(height: AppSpace.s8),
          Wrap(
            spacing: AppSpace.s8,
            runSpacing: AppSpace.s8,
            children: [
              for (final option in options)
                BaseChoiceChip(label: option, onTap: () => cubit.send(option)),
            ],
          ),
        ],
      ],
    );
  }
}

class const _Entry() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.chat;
    final hour = clock.now().hour;
    final period = hour < 12
        ? 'morning'
        : hour < 18
        ? 'afternoon'
        : 'evening';

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox.square(
            dimension: 56,
            child: FittedBox(
              child: BaseFace(kind: FaceKind.smile, size: FaceSize.small),
            ),
          ),
          const SizedBox(height: AppSpace.s16),
          Text(
            l10n.greeting.selectOrFallback(period),
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s4),
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.entryTitle,
              highlight: l10n.entryHighlight,
              style: context.text.titleXl,
            ),
          ),
        ],
      ),
    );
  }
}

class const _Composer() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.chat;
    final isOffline = context.select((ConnectivityCubit cubit) => cubit.state.isOffline);
    final draft = context.select((ChatCubit cubit) => cubit.state.draft);
    final isReplying = context.select((ChatCubit cubit) => cubit.state.isReplying);
    final messagesLeft = context.select((ChatCubit cubit) => cubit.state.messagesLeft);
    final limit = context.select((ChatCubit cubit) => cubit.state.limit);
    final cubit = context.read<ChatCubit>();
    final isComposerEnabled = !isReplying && !isOffline;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: BaseTextField(
                text: draft.value,
                hint: l10n.inputHint,
                errorText: l10n.draftErrors.selectOrNull(draft.errorName),
                isEnabled: !isReplying && !isOffline,
                onChanged: cubit.onDraftChanged,
                onSubmitted: (_) => cubit.sendDraft(),
              ),
            ),
            const SizedBox(width: AppSpace.s8),
            _SendButton(
              key: const ValueKey('chatSend'),
              isEnabled: isComposerEnabled,
              onPressed: cubit.sendDraft,
              semanticLabel: l10n.send,
            ),
          ],
        ),
        if (isOffline) ...[
          const SizedBox(height: AppSpace.s4),
          Text(
            l10n.offline,
            style: context.text.bodySm.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s8),
          const _OfflineAlternatives(),
        ] else if (_isRunningLow(messagesLeft: messagesLeft, limit: limit)) ...[
          const SizedBox(height: AppSpace.s8),
          if (limit > 0)
            BaseMeter(
              value: limit - messagesLeft,
              max: limit,
              label: l10n.messagesLeft(count: messagesLeft),
              isThin: true,
            )
          else
            Text(
              l10n.messagesLeft(count: messagesLeft),
              style: context.text.bodySm.copyWith(color: context.colors.textSecondary),
            ),
        ],
      ],
    );
  }
}

/// Whether 80% of the day's messages are used, or only two are left.
bool _isRunningLow({required int messagesLeft, required int limit}) =>
    messagesLeft <= 2 || (limit > 0 && (limit - messagesLeft) * 5 >= limit * 4);

/// What the person can do while the chat is out of reach.
class const _OfflineAlternatives() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.chat;

    return Row(
      spacing: AppSpace.s8,
      children: [
        Expanded(
          child: BaseButton.compact(
            text: l10n.offlineSlip,
            onPressed: () => context.router.root.push(const QuickSlipRoute()),
          ),
        ),
        Expanded(
          child: BaseButton.compact(
            text: l10n.offlineDiary,
            onPressed: () => context.pushRoute(const DiaryRoute()),
          ),
        ),
      ],
    );
  }
}

class const _SendButton({
  required final bool isEnabled,
  required final VoidCallback onPressed,
  required final String semanticLabel,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: semanticLabel,
      child: AppPressable(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        enforceMinTapTarget: true,
        isSemanticButton: false,
        child: SizedBox(
          width: 40,
          height: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(color: colors.actionPrimary, shape: BoxShape.circle),
            child: Center(
              child: AppIcon(icon: AppIcons.send, size: AppIconSize.sm, color: colors.textOnAction),
            ),
          ),
        ),
      ),
    );
  }
}

class const _Message({required final ChatMessage message}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.chat;
    final cubit = context.read<ChatCubit>();

    if (message.role == ChatRole.user) {
      return Align(
        alignment: Alignment.centerRight,
        child: BaseBubble(variant: BaseBubbleVariant.own, text: message.text),
      );
    }

    if (message.isStreaming && message.text.isEmpty) {
      return const Align(
        alignment: Alignment.centerLeft,
        child: BaseBubble(variant: BaseBubbleVariant.typing),
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: BaseBubble(
        isFailed: message.isInterrupted,
        text: message.text.isEmpty ? l10n.interrupted : message.text,
        action: message.isInterrupted
            ? BaseTextLink(text: l10n.retry, onPressed: () => cubit.retry(message))
            : (message.isStreaming
                  ? null
                  : Wrap(
                      spacing: AppSpace.s12,
                      runSpacing: AppSpace.s4,
                      children: [
                        BaseTextLink(
                          text: l10n.saveAsSlip,
                          onPressed: () => cubit.saveAsSlip(message),
                        ),
                        BaseTextLink(
                          text: l10n.saveLearning,
                          onPressed: () => _saveLearning(context, message),
                        ),
                      ],
                    )),
      ),
    );
  }

  Future<void> _saveLearning(BuildContext context, ChatMessage message) async {
    final l10n = context.l10n.chat;
    final cubit = context.read<ChatCubit>();

    await BaseSheet.show<void>(
      context: context,
      title: l10n.learningSheetTitle,
      child: SaveLearningSheet(
        initialText: message.text,
        onSave: (target, text) {
          cubit.saveLearning(target: target, text: text, excerpt: message.text);
        },
      ),
    );
  }
}
