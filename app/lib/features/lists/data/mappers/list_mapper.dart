import 'package:app/features/lists/data/data_sources/remote/fragments/generated/ListFragment.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/fragments/generated/ListItemFragment.graphql.dart';
import 'package:app/features/lists/data/mappers/list_enum_mapper.dart';
import 'package:app/features/lists/data/models/list_models.dart';

extension ListFragmentMapper on FragmentListFragment {
  CoupleList toModel({required String? currentUserId}) => CoupleList(
    id: id,
    title: title,
    kind: kind.toModel(),
    isMine: authorId == currentUserId,
    isShared: coupleId != null,
  );
}

extension ListItemFragmentMapper on FragmentListItemFragment {
  ListItem toModel() =>
      ListItem(id: id, listId: listId, title: title, status: status.toModel(), position: position);
}
