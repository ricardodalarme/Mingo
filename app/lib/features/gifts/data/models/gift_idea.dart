import 'package:app/features/gifts/data/models/gift_idea_status.dart';
import 'package:equatable/equatable.dart';

/// The longest gift title the server accepts.
const int giftTitleMaxLength = 120;

/// The longest gift note the server accepts.
const int giftNoteMaxLength = 1000;

/// The longest gift link the server accepts.
const int giftLinkMaxLength = 500;

/// One wish on a person's gift page.
///
/// A wish is always shared with the current partner; [isMine] is false for
/// wishes the partner added.
final class const GiftIdea({
  required final String id,
  required final String title,
  final String? note,
  final String? link,
  final GiftIdeaStatus status = GiftIdeaStatus.idea,
  final bool isMine = false,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => const GiftIdea(
    id: 'fake',
    title: 'Livro de poemas',
    note: 'Capa dura',
    link: 'https://example.com/livro',
    isMine: true,
  );

  GiftIdea withDetails({required String title, required String? note, required String? link}) =>
      GiftIdea(id: id, title: title, note: note, link: link, status: status, isMine: isMine);

  @override
  List<Object?> get props => [id, title, note, link, status, isMine];
}
