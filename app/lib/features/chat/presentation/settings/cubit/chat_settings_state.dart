part of 'chat_settings_cubit.dart';

final class const ChatSettingsState({
  final Resource<void> status = const Loading(),
  final int messagesLeft = 0,
  final int limit = 0,
  final bool hasPlus = false,
}) with Equatable {
  ChatSettingsState copyWith({
    Resource<void>? status,
    int? messagesLeft,
    int? limit,
    bool? hasPlus,
  }) {
    return ChatSettingsState(
      status: status ?? this.status,
      messagesLeft: messagesLeft ?? this.messagesLeft,
      limit: limit ?? this.limit,
      hasPlus: hasPlus ?? this.hasPlus,
    );
  }

  @override
  List<Object?> get props => [status, messagesLeft, limit, hasPlus];
}
