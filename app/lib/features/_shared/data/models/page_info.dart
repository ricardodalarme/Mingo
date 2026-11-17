import 'package:equatable/equatable.dart';

/// One page of [items] and where the next page starts.
final class const PageInfo<T>({
  required final List<T> items,
  required final bool hasNext,
  final int offset = 0,
}) with Equatable {
  @override
  List<Object?> get props => [items, hasNext, offset];
}
