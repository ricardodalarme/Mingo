import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/devices/data/data_sources/remote/queries/generated/MyDevices.graphql.dart';
import 'package:app/features/devices/data/mappers/device_mapper.dart';
import 'package:app/features/devices/data/models/device_platform.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  QueryMyDevicesdevices node(String? label) => QueryMyDevicesdevices(
    id: 'dev1',
    platform: EnumDevicePlatform_enum.ios,
    label: label,
    lastSeenAt: DateTime.utc(2026, 3, 1),
  );

  test('the marker is stripped from the name the person sees', () {
    final device = node('iPhone de Ana#abc123').toModel(currentMarker: 'zzz');

    expect(device.label, 'iPhone de Ana');
    expect(device.platform, DevicePlatform.ios);
    expect(device.lastSeenAt, DateTime.utc(2026, 3, 1));
  });

  test('a device whose marker is the stored one is the current device', () {
    expect(node('iPhone#abc123').toModel(currentMarker: 'abc123').isCurrent, isTrue);
    expect(node('iPhone#abc123').toModel(currentMarker: 'other').isCurrent, isFalse);
  });

  test('no stored marker means no device is current', () {
    expect(node('iPhone#abc123').toModel(currentMarker: null).isCurrent, isFalse);
  });

  test('a label without a marker is the name, and never the current device', () {
    final device = node('iPhone').toModel(currentMarker: 'abc123');

    expect(device.label, 'iPhone');
    expect(device.isCurrent, isFalse);
  });

  test('a device with no label has none', () {
    expect(node(null).toModel(currentMarker: 'abc123').label, isNull);
  });

  test('the name keeps a hash that is not the last one', () {
    expect(node('A#B#c1').toModel(currentMarker: 'c1').label, 'A#B');
  });
}
