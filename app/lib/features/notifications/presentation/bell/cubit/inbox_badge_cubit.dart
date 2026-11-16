import 'dart:async';

import 'package:app/features/notifications/data/repositories/inbox_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// How many notifications are unread, kept current while the screen that shows the bell is open.
class InboxBadgeCubit({required final InboxRepository _inboxRepository}) extends Cubit<int> {
  this : super(0);

  StreamSubscription<int>? _subscription;

  /// Starts following the unread count; a failed subscription leaves the last count.
  void start() {
    if (_subscription != null) return;

    _subscription = _inboxRepository.watchUnreadCount().listen(emit, onError: (Object _) {});
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();

    return super.close();
  }
}
