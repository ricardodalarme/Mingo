import 'package:app/features/devices/data/data_sources/remote/queries/generated/MyDevices.graphql.dart';
import 'package:app/features/devices/data/mappers/device_platform_mapper.dart';
import 'package:app/features/devices/data/models/device.dart';

extension DeviceMapper on QueryMyDevicesdevices {
  /// The device, with the marker the label carries stripped from its name. It is the current device
  /// when that marker is [currentMarker].
  Device toModel({required String? currentMarker}) {
    final index = label?.lastIndexOf('#') ?? -1;
    final name = index == -1 ? label : label!.substring(0, index);
    final marker = index == -1 ? null : label!.substring(index + 1);

    return Device(
      id: id,
      platform: platform.toModel(),
      label: name,
      lastSeenAt: lastSeenAt,
      isCurrent: currentMarker != null && marker == currentMarker,
    );
  }
}
