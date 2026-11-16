part of 'gentle_request_cubit.dart';

final class const GentleRequestState({
  final FormInput<String> whenText = const FormInput(''),
  final FormInput<String> feelText = const FormInput(''),
  final FormInput<String> wishText = const FormInput(''),
  final String? partnerName,
  final Resource<void> sendAction = const Initial(),
}) with Equatable {
  /// Whether all three sentences have something to send.
  bool get isComplete =>
      whenText.value.trim().isNotEmpty &&
      feelText.value.trim().isNotEmpty &&
      wishText.value.trim().isNotEmpty;

  GentleRequestState copyWith({
    FormInput<String>? whenText,
    FormInput<String>? feelText,
    FormInput<String>? wishText,
    String? partnerName,
    Resource<void>? sendAction,
  }) {
    return GentleRequestState(
      whenText: whenText ?? this.whenText,
      feelText: feelText ?? this.feelText,
      wishText: wishText ?? this.wishText,
      partnerName: partnerName ?? this.partnerName,
      sendAction: sendAction ?? this.sendAction,
    );
  }

  @override
  List<Object?> get props => [whenText, feelText, wishText, partnerName, sendAction];
}
