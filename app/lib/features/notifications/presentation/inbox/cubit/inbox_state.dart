part of 'inbox_cubit.dart';

final class const InboxState({
  final Resource<List<InboxItem>> items = const Loading(),
  final Resource<void> markAction = const Initial(),
  final String? partnerName,
}) with Equatable {
  InboxState copyWith({
    Resource<List<InboxItem>>? items,
    Resource<void>? markAction,
    String? partnerName,
  }) {
    return InboxState(
      items: items ?? this.items,
      markAction: markAction ?? this.markAction,
      partnerName: partnerName ?? this.partnerName,
    );
  }

  @override
  List<Object?> get props => [items, markAction, partnerName];
}
