import 'package:app/features/notifications/data/data_sources/remote/inbox_data_source.dart';
import 'package:app/features/notifications/data/mappers/inbox_item_mapper.dart';
import 'package:app/features/notifications/data/models/inbox_item.dart';
import 'package:clock/clock.dart';
import 'package:logger/logger.dart';

/// The most items the inbox page loads.
const int inboxLimit = 50;

class InboxRepository({required final InboxDataSource _dataSource}) {
  final Logger _logger = Logger('InboxRepository');

  Future<List<InboxItem>> getItems() async {
    try {
      final rows = await _dataSource.getItems(inboxLimit);

      return [for (final row in rows) ?row.toModel()];
    } catch (e, stack) {
      _logger.error('Failed to load the inbox', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> markAllRead() async {
    try {
      await _dataSource.markAllRead(clock.now().toUtc());
    } catch (e, stack) {
      _logger.error('Failed to mark the inbox read', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Emits how many items are unread, now and each time that changes.
  Stream<int> watchUnreadCount() {
    return _dataSource.watchUnreadCount().handleError((Object e, StackTrace stack) {
      _logger.error('The inbox subscription failed', error: e, stackTrace: stack);
    });
  }
}
