import 'package:app/features/devices/data/data_sources/remote/mutations/generated/RevokeDevice.graphql.dart';
import 'package:app/features/devices/data/data_sources/remote/queries/generated/MyDevices.graphql.dart';
import 'package:network/network.dart';

class DevicesDataSource({required final GQLClient _client}) {
  /// Reads the devices that receive notifications, most recently registered first.
  Future<List<QueryMyDevicesdevices>> getDevices() async {
    final response = await _client.query(
      OptionsQueryMyDevices(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response, getData: (data) => data.devices);
  }

  /// Deletes one device row; false means there was nothing left to delete.
  Future<bool> revokeDevice(String deviceId) async {
    final response = await _client.mutate(
      OptionsMutationRevokeDevice(variables: VariablesMutationRevokeDevice(deviceId: deviceId)),
    );

    return validateResponseData(response, getData: (data) => data.deleteDevicesByPk != null);
  }
}
