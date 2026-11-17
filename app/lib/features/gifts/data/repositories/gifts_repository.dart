import 'package:app/features/gifts/data/data_sources/remote/gifts_data_source.dart';
import 'package:app/features/gifts/data/mappers/gift_enum_mapper.dart';
import 'package:app/features/gifts/data/mappers/gift_mapper.dart';
import 'package:app/features/gifts/data/models/gift_budget.dart';
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
        if (node.authorId == currentUserId || node.coupleId != null)
          node.toModel(currentUserId: currentUserId),
    ];
  }

  /// Adds the wish and returns it as the server stored it.
  Future<GiftIdea> addGiftWish({
    required String id,
    required String title,
    String? note,
    GiftBudget? budget,
    String? coupleId,
  }) async {
    final saved = await _dataSource.addGiftWish(
      id: id,
      title: title.trim(),
      note: _clean(note),
      budget: budget?.toRemote(),
      coupleId: coupleId,
    );

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  Future<GiftIdea> updateGiftWish({
    required String id,
    required String title,
    String? note,
    GiftBudget? budget,
  }) async {
    final saved = await _dataSource.updateGiftWish(
      id: id,
      title: title.trim(),
      note: _clean(note),
      budget: budget?.toRemote(),
    );

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  Future<void> deleteGiftWish(String id) => _dataSource.deleteGiftWish(id);

  Future<GiftIdea> setGiftWishVisibility({required String id, String? coupleId}) async {
    final saved = await _dataSource.setGiftWishVisibility(id: id, coupleId: coupleId);

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  String? _clean(String? value) {
    final trimmed = value?.trim();

    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
