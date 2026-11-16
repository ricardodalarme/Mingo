import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/devices/data/mappers/device_platform_mapper.dart';
import 'package:app/features/devices/data/models/device_platform.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps each platform', () {
    expect(EnumDevicePlatform_enum.ios.toModel(), DevicePlatform.ios);
    expect(EnumDevicePlatform_enum.android.toModel(), DevicePlatform.android);
  });

  test('a platform survives a trip to the remote enum and back', () {
    for (final value in DevicePlatform.values) {
      expect(value.toRemote().toModel(), value);
    }
  });

  test('an unknown platform is shown as android', () {
    expect(EnumDevicePlatform_enum.$unknown.toModel(), DevicePlatform.android);
  });
}
