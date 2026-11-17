import 'package:app/features/chat/data/repositories/chat_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_settings_state.dart';

class ChatSettingsCubit({required final ChatRepository _chatRepository})
    extends Cubit<ChatSettingsState> {
  this : super(const ChatSettingsState());

  /// Reads today's usage.
  Future<void> load() async {
    emit(state.copyWith(status: const Loading()));
    try {
      final status = await _chatRepository.getStatus();
      if (isClosed) return;
      emit(
        state.copyWith(
          status: const Success(null),
          messagesLeft: status.messagesLeft,
          limit: status.limit,
          hasPlus: status.hasPlus,
        ),
      );
    } catch (exception, stack) {
      addError(exception, stack);
      if (isClosed) return;
      emit(state.copyWith(status: Failure.fromObject(exception)));
    }
  }
}
