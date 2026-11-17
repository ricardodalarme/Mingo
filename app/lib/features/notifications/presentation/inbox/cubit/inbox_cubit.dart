import 'package:app/features/notifications/data/models/inbox_item.dart';
import 'package:app/features/notifications/data/repositories/inbox_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inbox_state.dart';

class InboxCubit({
  required final InboxRepository _inboxRepository,
  required final ProfileRepository _profileRepository,
}) extends Cubit<InboxState> {
  this : super(const InboxState());

  Future<void> load() async {
    if (state.items is! Success) emit(state.copyWith(items: const Loading()));
    final partnerName = await _readPartnerName();
    try {
      final items = await _inboxRepository.getItems();
      if (isClosed) return;
      emit(state.copyWith(items: Success(items), partnerName: partnerName));
    } catch (exception, stack) {
      addError(exception, stack);
      if (isClosed || state.items is Success) return;
      emit(state.copyWith(items: Failure.fromObject(exception)));
    }
  }

  Future<void> markAllRead() async {
    if (state.markAction.isLoading) return;

    emit(state.copyWith(markAction: const Loading()));
    try {
      await _inboxRepository.markAllRead();
      emit(state.copyWith(markAction: const Success(null)));
      emit(state.copyWith(markAction: const Initial()));
      await load();
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(markAction: Failure.fromObject(exception)));
      emit(state.copyWith(markAction: const Initial()));
    }
  }

  Future<String?> _readPartnerName() async {
    try {
      return (await _profileRepository.getMySettings()).partnerName;
    } on Object {
      return state.partnerName;
    }
  }
}
