import 'dart:async';

import 'package:core/core.dart';
import 'package:meta/meta.dart';

/// Base Result class
/// [S] represents the type of the success value
sealed class const Resource<S>() {
  bool get isLoading => this is Loading;
}

@immutable
final class const Initial() extends Resource<Never>;

@immutable
final class const Loading() extends Resource<Never>;

@immutable
final class const Success<S>(final S value) extends Resource<S> {
  @override
  bool operator ==(Object other) =>
      other is Success && other.runtimeType == runtimeType && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
final class const Failure(final LocalizedException exception) extends Resource<Never> {
  factory fromObject(Object object) => switch (object) {
    LocalizedException() => Failure(object),
    ParallelWaitError(:final errors) => switch (_firstError(errors)) {
      final Object error => Failure.fromObject(error),
      _ => const Failure(UnknownException()),
    },
    _ => const Failure(UnknownException()),
  };

  /// The first failure inside the error a parallel wait throws, which holds one slot per future.
  static Object? _firstError(Object? errors) => switch (errors) {
    Iterable<Object?>() => _firstAsync(errors),
    (final Object? a, final Object? b) => _firstAsync([a, b]),
    (final Object? a, final Object? b, final Object? c) => _firstAsync([a, b, c]),
    (final Object? a, final Object? b, final Object? c, final Object? d) => _firstAsync([
      a,
      b,
      c,
      d,
    ]),
    (final Object? a, final Object? b, final Object? c, final Object? d, final Object? e) =>
      _firstAsync([a, b, c, d, e]),
    (
      final Object? a,
      final Object? b,
      final Object? c,
      final Object? d,
      final Object? e,
      final Object? f,
    ) =>
      _firstAsync([a, b, c, d, e, f]),
    _ => null,
  };

  static Object? _firstAsync(Iterable<Object?> slots) =>
      slots.whereType<AsyncError>().firstOrNull?.error;

  @override
  bool operator ==(Object other) =>
      other is Failure && other.runtimeType == runtimeType && other.exception == exception;

  @override
  int get hashCode => exception.hashCode;
}
