import 'package:app/features/agreements/data/data_sources/remote/fragments/generated/AgreementFragment.graphql.dart';
import 'package:app/features/agreements/data/models/agreement.dart';

extension AgreementMapper on FragmentAgreementFragment {
  /// The agreement as [currentUserId] sees it: theirs when they wrote it, shared when it has a couple.
  Agreement toModel({required String? currentUserId}) => Agreement(
    id: id,
    body: body,
    isMine: authorId == currentUserId,
    isShared: coupleId != null,
    isConfirmed: confirmedAt != null,
  );
}
