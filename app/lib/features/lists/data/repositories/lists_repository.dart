import 'package:app/features/lists/data/data_sources/remote/lists_data_source.dart';
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

  Future<List<CoupleList>> getLists() => _run('read lists', () async {
    final currentUserId = await _togetherRepository.getCurrentUserId();

    return [
      for (final node in await _dataSource.getLists()) node.toModel(currentUserId: currentUserId),
    ];
  });

  Future<ListDetail> getList(String id) => _run('read a list', () async {
    final node = await _dataSource.getList(id);
    if (node == null) throw const LocalizedException(l10nKey: listNotFoundCode);

    return ListDetail(
      list: node.toModel(currentUserId: await _togetherRepository.getCurrentUserId()),
      items: [for (final item in node.items) item.toModel()],
      currentCoupleId: await _togetherRepository.getCoupleId(),
    );
  });

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

          return ListDetail(
            list: record.list.toModel(currentUserId: currentUserId),
            items: [for (final item in record.items) item.toModel()],
            currentCoupleId: coupleId,
          );
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
  }) => _run('create a list', () async {
    final saved = await _dataSource.createList(
      id: id,
      title: title.trim(),
      kind: kind.toRemote(),
      coupleId: coupleId,
    );

    return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
  });

  Future<CoupleList> renameList({required String id, required String title}) =>
      _run('rename a list', () async {
        final saved = await _dataSource.renameList(id: id, title: title.trim());

        return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
      });

  Future<void> deleteList(String id) => _run('delete a list', () => _dataSource.deleteList(id));

  Future<CoupleList> setListVisibility({required String id, String? coupleId}) =>
      _run('change a list visibility', () async {
        final saved = await _dataSource.setListVisibility(id: id, coupleId: coupleId);

        return saved.toModel(currentUserId: await _togetherRepository.getCurrentUserId());
      });

  Future<ListItem> addItem({
    required String id,
    required String listId,
    required String title,
    required int position,
  }) => _run(
    'add an item',
    () async => (await _dataSource.addItem(
      id: id,
      listId: listId,
      title: title.trim(),
      position: position,
    )).toModel(),
  );

  Future<ListItem> setItemStatus({required String id, required ListItemStatus status}) => _run(
    'update an item',
    () async => (await _dataSource.setItemStatus(id: id, status: status.toRemote())).toModel(),
  );

  /// Moves the items to the order of [itemIds] in one request and returns the whole list in order.
  Future<List<ListItem>> reorderItems({required String listId, required List<String> itemIds}) =>
      _run(
        'reorder items',
        () async => [
          for (final node in await _dataSource.reorderItems(listId: listId, itemIds: itemIds))
            node.toModel(),
        ],
      );

  Future<void> deleteItem(String id) => _run('delete an item', () => _dataSource.deleteItem(id));

  Future<T> _run<T>(String what, Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, stack) {
      _logger.error('Failed to $what', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
