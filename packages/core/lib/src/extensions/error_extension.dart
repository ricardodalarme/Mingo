import 'dart:async';

extension ErrorExtension on Object {
  /// The first failure inside the error a parallel wait throws, or this object when it is not one.
  ///
  /// A parallel wait holds one slot per future, so the failure is the first slot that failed.
  Object unwrapParallelWaitError() {
    final error = this;
    if (error is! ParallelWaitError) return error;
    final inner = _firstError(error.errors);

    return inner == null ? error : inner.unwrapParallelWaitError();
  }

  Object? _firstError(Object? errors) => switch (errors) {
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

  Object? _firstAsync(Iterable<Object?> slots) => slots.whereType<AsyncError>().firstOrNull?.error;
}
