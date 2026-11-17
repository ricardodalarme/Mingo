import 'package:app/features/chat/data/data_sources/remote/learned_items_data_source.dart';
import 'package:app/features/chat/data/mappers/learned_item_enum_mapper.dart';
import 'package:app/features/chat/data/mappers/learned_item_mapper.dart';
import 'package:app/features/chat/data/models/learned_item.dart';

class LearnedItemsRepository({required final LearnedItemsDataSource _dataSource}) {
  Future<List<LearnedItem>> getItems() async {
    return [for (final node in await _dataSource.getItems()) node.toModel()];
  }

  /// Saves a new pending learning; nothing is sent to the partner.
  Future<void> add({required LearnedTarget target, required String text, String? excerpt}) async {
    final trimmed = text.trim();
    final trimmedExcerpt = excerpt?.trim();
    await _dataSource.add(
      target: target.toRemote(),
      text: trimmed,
      excerpt: trimmedExcerpt == null
          ? null
          : trimmedExcerpt.length > learnedExcerptMaxLength
          ? trimmedExcerpt.substring(0, learnedExcerptMaxLength)
          : trimmedExcerpt,
    );
  }

  Future<void> updateText(String id, String text) async {
    await _dataSource.updateText(id: id, text: text.trim());
  }

  Future<void> setStatus(String id, LearnedStatus status) async {
    await _dataSource.setStatus(id: id, status: status.toRemote());
  }

  Future<void> delete(String id) async {
    await _dataSource.delete(id);
  }
}
