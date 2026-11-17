import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceDesires.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';

extension SpiceDesireMapper on QuerySpiceDesirescontentItems {
  /// The desire with the person's own [answer], when they gave one.
  SpiceDesire toModel({SpiceAnswer? answer}) => SpiceDesire(
    slug: slug,
    title: title,
    level: level?.toSpiceLevel() ?? SpiceLevel.soft,
    answer: answer,
  );
}
