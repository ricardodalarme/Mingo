import 'package:app/features/spice/data/data_sources/remote/queries/generated/MySpiceSettings.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_settings_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the stored limit and notifications become the settings', () {
    final settings = QueryMySpiceSettingsuserSettingsByPk(
      userId: 'me',
      spiceMaxLevel: 3,
      spiceNotifications: true,
    ).toModel();

    expect(settings.maxLevel, SpiceLevel.hot);
    expect(settings.notifications, isTrue);
  });
}
