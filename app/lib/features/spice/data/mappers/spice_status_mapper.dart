import 'package:app/features/spice/data/data_sources/remote/spice_data_source.dart';
import 'package:app/features/spice/data/mappers/spice_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';

extension SpiceStatusMapper on SpiceStateRecord {
  SpiceStatus toModel() => SpiceStatus(
    stage: state.toModel(),
    myLevel: myLevel?.toSpiceLevel() ?? SpiceLevel.soft,
    coupleLevel: coupleLevel?.toSpiceLevel(),
  );
}
