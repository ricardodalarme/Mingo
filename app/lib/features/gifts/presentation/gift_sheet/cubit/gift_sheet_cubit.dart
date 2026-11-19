import 'package:app/features/gifts/data/models/gift_idea.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

part 'gift_sheet_state.dart';

/// Draft state of the add/edit gift sheet; the sheet pops with the result of [submit].
class GiftSheetCubit() extends Cubit<GiftSheetState> {
  this : super(const GiftSheetState());

  void start({GiftIdea? gift}) => emit(
    GiftSheetState(
      title: FormInput(gift?.title ?? ''),
      note: FormInput(gift?.note ?? ''),
      link: FormInput(gift?.link ?? ''),
      isEditing: gift != null,
    ),
  );

  void onTitleChanged(String title) => emit(state.copyWith(title: FormInput(title)));

  void onNoteChanged(String note) => emit(state.copyWith(note: FormInput(note)));

  void onLinkChanged(String link) => emit(state.copyWith(link: FormInput(link)));

  /// Validates the fields and returns the draft, or null when a field is invalid.
  ({String title, String? note, String? link})? submit() {
    final validatedTitle = state.title.validate(
      CompositeValidator<String>([NonEmptyValidator(), MaxLengthValidator(giftTitleMaxLength)]),
    );
    final validatedNote = state.note.validate(MaxLengthValidator(giftNoteMaxLength));
    final validatedLink = _validateLink(state.link);

    emit(state.copyWith(title: validatedTitle, note: validatedNote, link: validatedLink));

    if (!validatedTitle.isValid || !validatedNote.isValid || !validatedLink.isValid) return null;

    return (
      title: validatedTitle.value.trim(),
      note: _clean(validatedNote.value),
      link: _clean(validatedLink.value),
    );
  }

  FormInput<String> _validateLink(FormInput<String> link) {
    if (link.value.trim().isEmpty) return FormInput(link.value);

    return link.validate(
      CompositeValidator<String>([UrlValidator(), MaxLengthValidator(giftLinkMaxLength)]),
    );
  }

  String? _clean(String value) {
    final trimmed = value.trim();

    return trimmed.isEmpty ? null : trimmed;
  }
}
