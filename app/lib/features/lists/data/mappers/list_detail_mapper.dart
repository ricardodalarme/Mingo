import 'package:app/features/lists/data/data_sources/remote/lists_data_source.dart';
import 'package:app/features/lists/data/mappers/list_mapper.dart';
import 'package:app/features/lists/data/models/list_models.dart';

extension ListDetailMapper on ListDetailRecord {
  /// The list with its items, from the point of view of [currentUserId] and [currentCoupleId].
  ListDetail toModel({required String? currentUserId, required String? currentCoupleId}) =>
      ListDetail(
        list: list.toModel(currentUserId: currentUserId),
        items: [for (final item in items) item.toModel()],
        currentCoupleId: currentCoupleId,
      );
}
