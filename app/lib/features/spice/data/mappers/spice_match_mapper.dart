import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceMatches.graphql.dart';
import 'package:app/features/spice/data/models/spice_models.dart';

extension SpiceMatchMapper on QuerySpiceMatchesspiceMatches {
  SpiceMatch toModel() => SpiceMatch(slug: slug, title: title);
}
