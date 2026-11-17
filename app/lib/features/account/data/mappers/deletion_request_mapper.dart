import 'package:app/features/account/data/data_sources/remote/fragments/generated/DeletionRequestFragment.graphql.dart';
import 'package:app/features/account/data/models/deletion_request.dart';

extension DeletionRequestMapper on FragmentDeletionRequestFragment {
  DeletionRequest toModel() => DeletionRequest(requestedAt: requestedAt, purgeAfter: purgeAfter);
}
