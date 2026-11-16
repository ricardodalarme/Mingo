part of 'today_cubit.dart';

final class const TodayState({
  final Resource<TodayHome> home = const Loading(),
  final bool isOffline = false,
  final String? selfName,
  final String? partnerHint,
  final bool isFirstDay = false,
  final bool isSoloOnly = false,
  final bool showUnpairNotice = false,
  final String? unpairedPartnerName,
}) with Equatable {
  TodayState copyWith({
    Resource<TodayHome>? home,
    bool? isOffline,
    String? selfName,
    String? partnerHint,
    bool? isFirstDay,
    bool? isSoloOnly,
    bool? showUnpairNotice,
    String? unpairedPartnerName,
  }) {
    return TodayState(
      home: home ?? this.home,
      isOffline: isOffline ?? this.isOffline,
      selfName: selfName ?? this.selfName,
      partnerHint: partnerHint ?? this.partnerHint,
      isFirstDay: isFirstDay ?? this.isFirstDay,
      isSoloOnly: isSoloOnly ?? this.isSoloOnly,
      showUnpairNotice: showUnpairNotice ?? this.showUnpairNotice,
      unpairedPartnerName: unpairedPartnerName ?? this.unpairedPartnerName,
    );
  }

  @override
  List<Object?> get props => [
    home,
    isOffline,
    selfName,
    partnerHint,
    isFirstDay,
    isSoloOnly,
    showUnpairNotice,
    unpairedPartnerName,
  ];
}
