import 'dart:async';

import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  ParallelWaitError<dynamic, dynamic> waitFailedWith(Object? errors) =>
      ParallelWaitError<dynamic, dynamic>(null, errors);

  test('an error that is not a parallel wait is itself', () {
    final error = StateError('boom');

    expect(error.unwrapParallelWaitError(), same(error));
  });

  test('a parallel wait over a list gives its first failure', () {
    final failure = StateError('boom');
    final wait = waitFailedWith([null, AsyncError(failure, StackTrace.empty)]);

    expect(wait.unwrapParallelWaitError(), same(failure));
  });

  test('a parallel wait over a record gives its first failure', () {
    final failure = StateError('boom');
    final wait = waitFailedWith((null, AsyncError(failure, StackTrace.empty), null));

    expect(wait.unwrapParallelWaitError(), same(failure));
  });

  test('a parallel wait inside a parallel wait gives the innermost failure', () {
    final failure = StateError('boom');
    final inner = waitFailedWith([AsyncError(failure, StackTrace.empty)]);
    final outer = waitFailedWith([AsyncError(inner, StackTrace.empty)]);

    expect(outer.unwrapParallelWaitError(), same(failure));
  });

  test('a parallel wait with no readable failure is itself', () {
    final wait = waitFailedWith((null, null, null, null, null, null, null));

    expect(wait.unwrapParallelWaitError(), same(wait));
  });
}
