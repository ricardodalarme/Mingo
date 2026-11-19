import 'package:app/features/gifts/data/models/gift_idea.dart';
import 'package:app/features/gifts/presentation/gift_sheet/cubit/gift_sheet_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// What the gift sheet hands back to the page.
final class const GiftDraft({
  final String title = '',
  final String? note,
  final String? link,
  final bool isDelete = false,
});

/// The sheet that adds or edits one wish.
class const GiftSheet({final GiftIdea? gift, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GiftSheetCubit()..start(gift: gift),
      child: const _GiftSheetContent(),
    );
  }
}

class const _GiftSheetContent() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gifts;
    final title = context.select((GiftSheetCubit cubit) => cubit.state.title);
    final note = context.select((GiftSheetCubit cubit) => cubit.state.note);
    final link = context.select((GiftSheetCubit cubit) => cubit.state.link);
    final isEditing = context.select((GiftSheetCubit cubit) => cubit.state.isEditing);
    final cubit = context.read<GiftSheetCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseTextField(
          text: title.value,
          label: l10n.titleLabel,
          hint: l10n.titleHint,
          errorText: l10n.titleErrors.selectOrNull(title.errorName),
          onChanged: cubit.onTitleChanged,
        ),
        const SizedBox(height: AppSpace.s16),
        BaseTextArea(
          text: note.value,
          hint: l10n.noteHint,
          maxLength: giftNoteMaxLength,
          maxLines: 4,
          errorText: l10n.noteErrors.selectOrNull(note.errorName),
          onChanged: cubit.onNoteChanged,
        ),
        const SizedBox(height: AppSpace.s16),
        BaseTextField(
          text: link.value,
          label: l10n.linkLabel,
          hint: l10n.linkHint,
          type: .url,
          errorText: l10n.linkErrors.selectOrNull(link.errorName),
          onChanged: cubit.onLinkChanged,
        ),
        const SizedBox(height: AppSpace.s24),
        BaseButton(text: isEditing ? l10n.save : l10n.add, onPressed: () => _save(context)),
        if (isEditing) ...[
          const SizedBox(height: AppSpace.s10),
          BaseButton(
            text: l10n.delete,
            variant: .secondary,
            onPressed: () => Navigator.of(context).pop(const GiftDraft(isDelete: true)),
          ),
        ],
      ],
    );
  }

  void _save(BuildContext context) {
    final draft = context.read<GiftSheetCubit>().submit();
    if (draft == null) return;

    Navigator.of(context).pop(GiftDraft(title: draft.title, note: draft.note, link: draft.link));
  }
}
