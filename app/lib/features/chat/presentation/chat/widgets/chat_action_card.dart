import 'package:app/features/chat/data/models/chat_action.dart';
import 'package:app/features/chat/presentation/chat/cubit/chat_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A suggestion from the mascot; nothing runs until the person taps its button.
class const ChatActionCard({
  required final String messageId,
  required final int index,
  required final ChatAction action,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.chat.action;
    final cubit = context.read<ChatCubit>();
    final preview = action.prepared.text ?? _valueText(context);

    return BaseSurfaceCard(
      padding: const EdgeInsets.all(AppSpace.s14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.tags.selectOrFallback(action.tool),
            style: context.text.caption.copyWith(color: context.colors.textSecondary),
          ),
          if (preview != null) ...[
            const SizedBox(height: AppSpace.s6),
            Text(preview, style: context.text.body),
          ],
          const SizedBox(height: AppSpace.s6),
          Text(
            action.needsConfirmation ? l10n.partnerHint : l10n.privateHint,
            style: context.text.caption.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s10),
          switch (action.status) {
            ChatActionStatus.pending when action.prepared.isInformative => const SizedBox.shrink(),
            ChatActionStatus.pending => Row(
              spacing: AppSpace.s8,
              children: [
                Expanded(
                  child: BaseButton(
                    text: l10n.runLabels.selectOrFallback(action.tool),
                    onPressed: () {
                      final route = action.prepared.route;
                      if (route != null) {
                        context.pushRoute(route);
                      } else {
                        cubit.runAction(messageId, index);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: BaseButton(
                    text: l10n.dismiss,
                    variant: .secondary,
                    onPressed: () => cubit.dismissAction(messageId, index),
                  ),
                ),
              ],
            ),
            ChatActionStatus.running => Text(l10n.running, style: context.text.caption),
            ChatActionStatus.done => Text(l10n.done, style: context.text.caption),
            ChatActionStatus.dismissed => Text(l10n.dismissed, style: context.text.caption),
            ChatActionStatus.failed => BaseTextLink(
              text: '${l10n.failed} · ${l10n.retry}',
              onPressed: () => cubit.retryAction(messageId, index),
            ),
          },
        ],
      ),
    );
  }

  String? _valueText(BuildContext context) {
    final key = action.prepared.valueKey;
    if (key == null) return null;
    final l10n = context.l10n.chat.action;

    return l10n.moodText(mood: l10n.moods.selectOrFallback(key));
  }
}
