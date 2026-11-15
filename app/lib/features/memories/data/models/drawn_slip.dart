import 'package:equatable/equatable.dart';

/// A slip drawn from the jar, with the id its detail opens and the text to show.
final class const DrawnSlip({required final String id, required final String body}) with Equatable {
  @override
  List<Object?> get props => [id, body];
}
