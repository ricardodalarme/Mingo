part of 'settings_home_cubit.dart';

final class const SettingsHomeState({
  final bool isLoaded = false,
  final bool isAuthenticated = false,
  final String? partnerName,
  final bool? hasPartner,
  final bool? hasPlus,
  final bool? notificationsOn,
  final DateTime? deletionPurgeAfter,
}) with Equatable {
  bool get deletionPending => deletionPurgeAfter != null;

  bool get hasRelationship => hasPartner == true;

  @override
  List<Object?> get props => [
    isLoaded,
    isAuthenticated,
    partnerName,
    hasPartner,
    hasPlus,
    notificationsOn,
    deletionPurgeAfter,
  ];
}
