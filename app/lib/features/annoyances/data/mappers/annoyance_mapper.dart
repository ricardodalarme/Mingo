import 'package:app/features/annoyances/data/data_sources/remote/fragments/generated/AnnoyanceFragment.graphql.dart';
import 'package:app/features/annoyances/data/models/annoyance.dart';

extension AnnoyanceMapper on FragmentAnnoyanceFragment {
  Annoyance toModel() => Annoyance(id: id, body: body, createdAt: createdAt, expiresAt: expiresAt);
}
