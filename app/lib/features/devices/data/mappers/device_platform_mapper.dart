import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/devices/data/models/device_platform.dart';

extension EnumDevicePlatformMapper on EnumDevicePlatform_enum {
  DevicePlatform toModel() => switch (this) {
    EnumDevicePlatform_enum.ios => DevicePlatform.ios,
    EnumDevicePlatform_enum.android => DevicePlatform.android,
    EnumDevicePlatform_enum.$unknown => DevicePlatform.android,
  };
}

extension DevicePlatformMapper on DevicePlatform {
  EnumDevicePlatform_enum toRemote() => switch (this) {
    DevicePlatform.ios => EnumDevicePlatform_enum.ios,
    DevicePlatform.android => EnumDevicePlatform_enum.android,
  };
}
