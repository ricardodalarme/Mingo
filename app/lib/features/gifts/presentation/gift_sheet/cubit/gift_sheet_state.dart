part of 'gift_sheet_cubit.dart';

final class const GiftSheetState({
  final FormInput<String> title = const FormInput(''),
  final FormInput<String> note = const FormInput(''),
  final FormInput<String> link = const FormInput(''),
  final bool isEditing = false,
}) with Equatable {
  GiftSheetState copyWith({
    FormInput<String>? title,
    FormInput<String>? note,
    FormInput<String>? link,
    bool? isEditing,
  }) => GiftSheetState(
    title: title ?? this.title,
    note: note ?? this.note,
    link: link ?? this.link,
    isEditing: isEditing ?? this.isEditing,
  );

  @override
  List<Object?> get props => [title, note, link, isEditing];
}
