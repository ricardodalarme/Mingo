import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:preferences_service/preferences_service.dart';

/// Keeps the last written payload on the device so the gallery still has something to show offline.
class HomeWidgetsLocalDataSource({required final PreferencesService _preferencesService}) {
  static const String _cachedPayloadKey = 'widgetsCachedPayloadJson';

  HomeWidgetPayload? readCachedPayload() {
    final raw = _preferencesService.readString(key: _cachedPayloadKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      return HomeWidgetPayload.fromJsonString(raw);
    } on Object {
      return null;
    }
  }

  Future<void> writeCachedPayload(HomeWidgetPayload payload) =>
      _preferencesService.writeString(key: _cachedPayloadKey, value: payload.toJsonString());

  Future<void> clear() => _preferencesService.delete(key: _cachedPayloadKey);
}
