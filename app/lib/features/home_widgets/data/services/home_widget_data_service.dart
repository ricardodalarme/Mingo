import 'dart:async';

import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:clock/clock.dart';
import 'package:flutter/services.dart';
import 'package:home_widget_service/home_widget_service.dart';

/// Writes the payload to the store the home widgets read and keeps their timelines fresh.
///
/// Never logs the payload or the names in it.
class HomeWidgetDataService({
  final HomeWidgetService _homeWidget = const PlatformHomeWidgetService(),
}) {
  static const String appGroupId = 'group.dev.dalarme.mingo';
  static const String payloadStorageKey = 'mingo_widget_payload';
  static const String _androidPackage = 'dev.dalarme.mingo.widgets';

  bool _initialized = false;

  /// Deep links delivered while the app runs when a home widget is tapped.
  Stream<Uri?> get widgetClicked => _homeWidget.clicked;

  /// The deep link that launched the app from a home widget, if any.
  Future<Uri?> initiallyLaunchedFromHomeWidget() async {
    try {
      return await _homeWidget.initiallyLaunched();
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  /// Sanitizes [payload], writes it to the shared store and reloads every home widget.
  Future<HomeWidgetPayload> writePayload(
    HomeWidgetPayload payload, {
    DateTime? referenceNow,
  }) async {
    final sanitized = payload.sanitized(referenceNow: referenceNow);
    await _save(sanitized);
    await reloadAll();
    if (sanitized.isSignedIn) {
      await _scheduleMidnightRefresh(referenceNow: referenceNow);
    } else {
      await _cancelMidnightRefresh();
    }

    return sanitized;
  }

  /// Overwrites the shared store with the neutral signed-out payload.
  Future<HomeWidgetPayload> clearForSignOut({DateTime? referenceNow}) async {
    await _cancelMidnightRefresh();
    final neutral = HomeWidgetPayload.signedOut(now: referenceNow);
    await _save(neutral);
    await reloadAll();

    return neutral;
  }

  /// Asks every home widget to reload its timeline.
  Future<void> reloadAll() async {
    for (final kind in HomeWidgetKind.values) {
      await _ignoringMissingHost(
        () => _homeWidget.updateWidget(
          iosName: kind.iosKind,
          androidName: kind.androidReceiver,
          qualifiedAndroidName: kind.qualifiedAndroidReceiver,
        ),
      );
    }
  }

  Future<void> _save(HomeWidgetPayload payload) async {
    await _initialize();
    await _ignoringMissingHost(
      () => _homeWidget.saveString(payloadStorageKey, payload.toJsonString()),
    );
  }

  Future<void> _initialize() async {
    if (_initialized) return;
    _initialized = true;
    await _ignoringMissingHost(() => _homeWidget.setAppGroupId(appGroupId));
  }

  Future<void> _scheduleMidnightRefresh({DateTime? referenceNow}) async {
    final now = (referenceNow ?? clock.now()).toLocal();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    for (final kind in _midnightKinds) {
      await _ignoringMissingHost(
        () => _homeWidget.scheduleUpdates(
          [nextMidnight],
          name: kind.androidReceiver,
          androidName: kind.androidReceiver,
          qualifiedAndroidName: kind.qualifiedAndroidReceiver,
        ),
      );
    }
  }

  Future<void> _cancelMidnightRefresh() async {
    for (final kind in _midnightKinds) {
      await _ignoringMissingHost(
        () => _homeWidget.cancelScheduledUpdates(
          name: kind.androidReceiver,
          androidName: kind.androidReceiver,
          qualifiedAndroidName: kind.qualifiedAndroidReceiver,
        ),
      );
    }
  }

  static final List<HomeWidgetKind> _midnightKinds = [
    for (final kind in HomeWidgetKind.values)
      if (kind.refreshesAtMidnight) kind,
  ];

  // The shared store and the scheduler only exist on a device; tests and other hosts skip them.
  Future<void> _ignoringMissingHost(Future<void> Function() action) async {
    try {
      await action();
    } on PlatformException {
      return;
    } on MissingPluginException {
      return;
    }
  }
}

extension HomeWidgetKindNativeNames on HomeWidgetKind {
  /// The WidgetKit `kind` string of the home widget.
  String get iosKind => 'Mingo${_pascal}Widget';

  /// The Android receiver class name relative to the app package.
  String get androidReceiver => 'Mingo${_pascal}WidgetReceiver';

  /// The fully qualified Android receiver class name.
  String get qualifiedAndroidReceiver =>
      '${HomeWidgetDataService._androidPackage}.$androidReceiver';

  String get _pascal => name[0].toUpperCase() + name.substring(1);

  /// Whether the home widget shows a day count or a clock, so it reloads at midnight.
  bool get refreshesAtMidnight => switch (this) {
    .counter || .card || .distance || .nextDate => true,
    _ => false,
  };
}
