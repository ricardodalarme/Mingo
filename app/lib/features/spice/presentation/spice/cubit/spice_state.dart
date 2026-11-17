part of 'spice_cubit.dart';

final class const SpiceState({
  final Resource<SpiceStatus> status = const Loading(),
  final bool hasPartner = false,
  final bool isAdult = false,
  final bool showAdultError = false,
  final Resource<void> changeAction = const Initial(),
}) with Equatable {
  SpiceState copyWith({
    Resource<SpiceStatus>? status,
    bool? hasPartner,
    bool? isAdult,
    bool? showAdultError,
    Resource<void>? changeAction,
  }) {
    return SpiceState(
      status: status ?? this.status,
      hasPartner: hasPartner ?? this.hasPartner,
      isAdult: isAdult ?? this.isAdult,
      showAdultError: showAdultError ?? this.showAdultError,
      changeAction: changeAction ?? this.changeAction,
    );
  }

  @override
  List<Object?> get props => [status, hasPartner, isAdult, showAdultError, changeAction];
}
