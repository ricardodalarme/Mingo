import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SpiceNextCard.graphql.dart';
import 'package:app/features/spice/data/models/spice_models.dart';

extension SpiceCardMapper on MutationSpiceNextCardspiceNextCard {
  /// The card with its [text]; it is the person's own when they proposed it.
  SpiceCard toModel({required String text, required String userId}) =>
      SpiceCard(id: id, text: text, isMine: proposedBy == userId);
}
