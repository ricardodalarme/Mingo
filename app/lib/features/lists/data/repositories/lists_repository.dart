import 'package:app/features/lists/data/data_sources/remote/fragments/generated/ListItemFragment.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/lists_data_source.dart';
import 'package:app/features/lists/data/mappers/list_detail_mapper.dart';
import 'package:app/features/lists/data/mappers/list_enum_mapper.dart';
import 'package:app/features/lists/data/mappers/list_mapper.dart';
import 'package:app/features/lists/data/models/list_item_status.dart';
import 'package:app/features/lists/data/models/list_kind.dart';
import 'package:app/features/lists/data/models/list_models.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

class ListsRepository({
  required final ListsDataSource _dataSource,
  required final TogetherRepository _togetherRepository,
}) {
  final Logger _logger = Logger('ListsRepository');

  /// The id of the couple the person is in, or null when they are on their own.
  Future<String?> getCoupleId() => _togetherRepository.getCoupleId();

  Future<List<CoupleList>> getLists() async {
    final currentUserId = await _togetherRepository.getCurrentUserId();

    return [
      for (final node in await _dataSource.getLists()) node.toModel(currentUserId: currentUserId),
    ];
  }

  Future<ListDetail> getList(String id) async {
    final node = await _dataSource.getList(id);
    if (node == null) throw const LocalizedException(l10nKey: listNotFoundCode);

    return (list: node, items: List<FragmentListItemFragment>.of(node.items)).toModel(
      currentUserId: await _togetherRepository.getCurrentUserId(),
      currentCoupleId: await _togetherRepository.getCoupleId(),
    );
  }

  /// Emits the lists now and each time the partner or the person changes them.
  ///
  /// A failed event is logged and skipped, so a screen keeps what it shows.
  Stream<List<CoupleList>> watchLists() async* {
    final String? currentUserId;
    try {
      currentUserId = await _togetherRepository.getCurrentUserId();
    } catch (e, stack) {
      _logger.error('Failed to start the lists subscription', error: e, stackTrace: stack);

      return;
    }

    yield* _dataSource
        .watchLists()
        .map((nodes) => [for (final node in nodes) node.toModel(currentUserId: currentUserId)])
        .handleError((Object e, StackTrace stack) {
          _logger.error('The lists subscription failed', error: e, stackTrace: stack);
        });
  }

  /// Emits the list and its items now and each time either changes.
  ///
  /// Fails with [listNotFoundCode] once the list is gone, such as when the partner deletes it.
  Stream<ListDetail> watchList(String id) async* {
    final String? currentUserId;
    final String? coupleId;
    try {
      currentUserId = await _togetherRepository.getCurrentUserId();
      coupleId = await _togetherRepository.getCoupleId();
    } catch (e, stack) {
      _logger.error('Failed to start the list subscription', error: e, stackTrace: stack);

      return;
    }

    yield* _dataSource
        .watchList(id)
        .map((record) {
          if (record == null) throw const LocalizedException(l10nKey: listNotFoundCode);

          return record.toModel(currentUserId: currentUserId, currentCoupleId: coupleId);
        })
        .handleError((Object e, StackTrace stack) {
          _logger.error('The list subscription failed', error: e, stackTrace: stack);
        }, test: (e) => !(e is LocalizedException && e.l10nKey == listNotFoundCode));
  }

  /// Creates the list and returns it as the server stored it.
  Future<CoupleList> createList({
    required String id,
    required String title,
    required ListKind kind,
    String? coupleId,
  }) async {
    final saved = await _dataSource.createList(
      id: id,
      title: title.trim(),
      kind: kind.toRemote(),
      coupleId: coupleId,
    );

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  Future<CoupleList> renameList({required String id, required String title}) async {
    final saved = await _dataSource.renameList(id: id, title: title.trim());

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  Future<void> deleteList(String id) => _dataSource.deleteList(id);

  Future<CoupleList> setListVisibility({required String id, String? coupleId}) async {
    final saved = await _dataSource.setListVisibility(id: id, coupleId: coupleId);

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  }

  Future<ListItem> addItem({
    required String id,
    required String listId,
    required String title,
    required int position,
  }) async => (await _dataSource.addItem(
    id: id,
    listId: listId,
    title: title.trim(),
    position: position,
  )).toModel();

  Future<ListItem> setItemStatus({required String id, required ListItemStatus status}) async =>
      (await _dataSource.setItemStatus(id: id, status: status.toRemote())).toModel();

  /// Moves the items to the order of [itemIds] in one request and returns the whole list in order.
  Future<List<ListItem>> reorderItems({
    required String listId,
    required List<String> itemIds,
  }) async => [
    for (final node in await _dataSource.reorderItems(listId: listId, itemIds: itemIds))
      node.toModel(),
  ];

  Future<void> deleteItem(String id) => _dataSource.deleteItem(id);
}
