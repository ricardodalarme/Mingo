import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const AcceptInviteConnected({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.acceptInvite.connected;
    final partnerName = context.select((AcceptInviteCubit cubit) => cubit.state.partnerName);
    final selfName = context.select((AcceptInviteCubit cubit) => cubit.state.selfName);

    return BaseMomentContent(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseAvatarPair(
            size: .large,
            selfInitials: _initial(selfName),
            partnerInitials: _initial(partnerName),
          ),
          const SizedBox(height: AppSpace.s24),
          Semantics(
            header: true,
            liveRegion: true,
            child: AppHighlightedText(
              text: l10n.title,
              highlight: l10n.titleHighlight,
              style: context.text.display,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpace.s12),
          Text(
            l10n.text,
            textAlign: TextAlign.center,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ),
      footer: BaseButton(text: l10n.goToToday, onPressed: () => context.router.maybePop()),
    );
  }

  String _initial(String? name) =>
      name == null || name.isEmpty ? '?' : name.substring(0, 1).toUpperCase();
}
