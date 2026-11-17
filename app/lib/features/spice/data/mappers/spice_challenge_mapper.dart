import 'package:app/features/spice/data/data_sources/remote/fragments/generated/SpiceChallengeFragment.graphql.dart';
import 'package:app/features/spice/data/models/spice_models.dart';

extension SpiceChallengeMapper on FragmentSpiceChallengeFragment {
  /// The challenge as [userId] sees it, with its [text] and the swaps the couple has left.
  SpiceChallenge toModel({required String text, required String userId}) => SpiceChallenge(
    text: text,
    acceptedByMe: acceptedBy.contains(userId),
    doneByMe: doneBy.contains(userId),
    acceptedByPartner: acceptedBy.any((id) => id != userId),
    swapsLeft: spiceMaxSwaps - swaps,
  );
}
