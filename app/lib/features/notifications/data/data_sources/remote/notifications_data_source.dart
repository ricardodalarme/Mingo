import 'package:app/features/devices/data/mappers/device_platform_mapper.dart';
import 'package:app/features/devices/data/models/device_platform.dart';
import 'package:app/features/notifications/data/data_sources/remote/mutations/generated/RegisterDevice.graphql.dart';
import 'package:app/features/notifications/data/data_sources/remote/mutations/generated/UnregisterDevice.graphql.dart';
import 'package:app/features/notifications/data/data_sources/remote/mutations/generated/UpdateNotificationSettings.graphql.dart';
import 'package:app/features/notifications/data/data_sources/remote/queries/generated/MyNotificationSettings.graphql.dart';
import 'package:network/network.dart';

/// The notification choices kept on the server, with the muted types as their wire names.
typedef NotificationSettingsRow = ({
  bool isEnabled,
  Set<String> mutedTypes,
  int cardDay,
  int cardHour,
  int dailyMax,
});

class NotificationsDataSource({required final GQLClient _client}) {
  Future<NotificationSettingsRow> getSettings(String userId) async {
    final response = await _client.query(
      OptionsQueryMyNotificationSettings(
        variables: VariablesQueryMyNotificationSettings(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    final data = validateResponseData(response, getData: (data) => data);
    final settings = data.notificationSettingsByPk;
    if (settings == null) throw const NoDataException();

    return (
      isEnabled: settings.enabled,
      mutedTypes: {for (final mute in data.notificationMutes) mute.type.toJson()},
      cardDay: settings.cardDay,
      cardHour: settings.cardHour,
      dailyMax: settings.dailyMax,
    );
  }

  Future<void> updateSettings({
    required String userId,
    required bool enabled,
    required List<String> mutedTypes,
    required int cardDay,
    required int cardHour,
    required int dailyMax,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateNotificationSettings(
        variables: VariablesMutationUpdateNotificationSettings(
          userId: userId,
          enabled: enabled,
          cardDay: cardDay,
          cardHour: cardHour,
          dailyMax: dailyMax,
          mutes: mutedTypes,
        ),
      ),
    );

    validateResponse(response);
  }

  /// Returns whether the backend accepted this installation for the caller.
  Future<bool> registerDevice({
    required String token,
    required DevicePlatform platform,
    String? label,
  }) async {
    final response = await _client.mutate(
      OptionsMutationRegisterDevice(
        variables: VariablesMutationRegisterDevice(
          token: token,
          platform: platform.toRemote(),
          label: label,
        ),
      ),
    );

    return validateResponseData(response, getData: (data) => data.insertDevicesOne != null);
  }

  Future<void> unregisterDevice(String token) async {
    final response = await _client.mutate(
      OptionsMutationUnregisterDevice(variables: VariablesMutationUnregisterDevice(token: token)),
    );

    validateResponse(response);
  }
}
