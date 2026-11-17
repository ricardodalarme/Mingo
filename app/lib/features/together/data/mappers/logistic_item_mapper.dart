import 'package:app/features/together/data/data_sources/remote/fragments/generated/LogisticItemFragment.graphql.dart';
import 'package:app/features/together/data/models/logistic_item.dart';

extension LogisticItemMapper on FragmentLogisticItemFragment {
  LogisticItem toModel() => LogisticItem(
    id: id,
    title: title,
    assigneeId: assigneeId,
    authorId: authorId,
    isShared: coupleId != null,
    isConfirmed: confirmedAt != null,
    isDone: doneAt != null,
  );
}
