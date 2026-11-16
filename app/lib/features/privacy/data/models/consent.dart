import 'package:equatable/equatable.dart';

/// The consents the backend records, in the order the board lists them.
enum ConsentKind() {
  analytics,
  marketing,
  ai,
  terms;

  /// Whether the consent is required to use the app.
  bool get isRequired => this == terms;
}

/// The latest decision for one consent kind.
final class const Consent({required final ConsentKind kind, required final bool granted})
    with Equatable {
  @override
  List<Object?> get props => [kind, granted];
}
