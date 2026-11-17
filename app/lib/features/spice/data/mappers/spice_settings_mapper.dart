import 'package:app/features/spice/data/data_sources/remote/queries/generated/MySpiceSettings.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';

extension SpiceSettingsMapper on QueryMySpiceSettingsuserSettingsByPk {
  SpiceSettings toModel() =>
      SpiceSettings(maxLevel: spiceMaxLevel.toSpiceLevel(), notifications: spiceNotifications);
}
