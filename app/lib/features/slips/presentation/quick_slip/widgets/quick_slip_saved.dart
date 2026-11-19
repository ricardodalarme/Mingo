import 'package:app/features/slips/data/mappers/slip_note_mapper.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/quick_slip/cubit/quick_slip_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Width of the saved note.
const double _noteWidth = 230;

class const QuickSlipSaved({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.quickSlip.saved;
    final outcome = context.select((QuickSlipCubit cubit) => cubit.state.saveAction);
    final isAnnoyance = context.select(
      (QuickSlipCubit cubit) => cubit.state.mode == QuickSlipMode.annoyance,
    );
    final isQueued = outcome is Success<SlipSaveOutcome> && outcome.value == SlipSaveOutcome.queued;
    final title = isAnnoyance ? l10n.annoyanceTitle : l10n.title;

    return BaseMomentContent(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BaseFace(kind: FaceKind.smile, size: FaceSize.showcase),
          const SizedBox(height: AppSpace.s20),
          Semantics(
            header: true,
            liveRegion: true,
            child: AppHighlightedText(
              text: title,
              highlight: title,
              textAlign: TextAlign.center,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            isAnnoyance
                ? l10n.annoyanceAdded
                : isQueued
                ? l10n.queued
                : l10n.added,
            textAlign: TextAlign.center,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s24),
          const _SavedNote(),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _UndoToast(),
          BaseButton(text: l10n.done, onPressed: () => context.router.maybePop()),
        ],
      ),
    );
  }
}

/// The note that was just saved, at wall size.
class const _SavedNote() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.quickSlip;
    final text = context.select((QuickSlipCubit cubit) => cubit.state.text.value);
    final category = context.select((QuickSlipCubit cubit) => cubit.state.category);
    final isAnnoyance = context.select(
      (QuickSlipCubit cubit) => cubit.state.mode == QuickSlipMode.annoyance,
    );
    final day = context.l10n.slipsList.weekdaysShort[clock.now().weekday - 1];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _noteWidth),
      child: BaseSlipNote(
        text: text.trim(),
        type: isAnnoyance ? SlipNoteType.annoyed : category.toNoteType(),
        typeLabel: isAnnoyance
            ? l10n.polarityBothered
            : category == null
            ? l10n.polarityLiked
            : l10n.categories.selectOrFallback(category.name),
        dayLabel: day,
        tilt: slipNoteTilt('quick'),
      ),
    );
  }
}

/// The 30 second undo, shown over the footer while the slip can still be taken back.
class const _UndoToast() extends StatefulWidget {
  @override
  State<_UndoToast> createState() => _UndoToastState();
}

class _UndoToastState() extends State<_UndoToast> {
  bool _isDismissed = false;

  @override
  Widget build(BuildContext context) {
    final canUndo = context.select((QuickSlipCubit cubit) => cubit.state.canUndo);
    if (!canUndo || _isDismissed) return const SizedBox.shrink();

    final l10n = context.l10n.quickSlip.saved;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.s10),
      child: BaseToast(
        message: l10n.undoHint,
        actionLabel: l10n.undo,
        onAction: context.read<QuickSlipCubit>().undo,
        onDismissed: () => setState(() => _isDismissed = true),
      ),
    );
  }
}
