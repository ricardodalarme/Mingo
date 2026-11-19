import 'package:app/features/gifts/data/data_sources/remote/gifts_data_source.dart';
import 'package:app/features/gifts/data/mappers/gift_mapper.dart';
import 'package:app/features/gifts/data/models/gift_idea.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';

class GiftsRepository({
  required final GiftsDataSource _dataSource,
  required final TogetherRepository _togetherRepository,
}) {
  /// The id of the couple the person is in, or null when they are on their own.
  Future<String?> getCoupleId() => _togetherRepository.getCoupleId();

  Future<List<GiftIdea>> getGiftIdeas() async {
    final currentUserId = await _togetherRepository.getCurrentUserId();

    return [
      for (final node in await _dataSource.getGiftIdeas())
        node.toModel(currentUserId: currentUserId),
    ];
  }

  /// Adds the wish and returns it as the server stored it.
  Future<GiftIdea> addGiftWish({
    required String id,
    required String title,
    String? note,
    String? link,
  }) async {
    final saved = await _dataSource.addGiftWish(
      id: id,
      title: title.trim(),
      note: _clean(note),
      link: _clean(link),
    );

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  Future<GiftIdea> updateGiftWish({
    required String id,
    required String title,
    String? note,
    String? link,
  }) async {
    final saved = await _dataSource.updateGiftWish(
      id: id,
      title: title.trim(),
      note: _clean(note),
      link: _clean(link),
    );

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  Future<void> deleteGiftWish(String id) => _dataSource.deleteGiftWish(id);

  String? _clean(String? value) {
    final trimmed = value?.trim();

    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
