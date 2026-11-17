import 'dart:async';

import 'package:app/infrastructure/observers/bloc_error_observer.dart';
import 'package:core/core.dart';
import 'package:crash_report_service/crash_report_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockCrashReportService() extends Mock implements CrashReportService;

class _Counter() extends Cubit<int> {
  this : super(0);
}

void main() {
  late CrashReportService crashReports;
  late BlocErrorObserver observer;
  late _Counter cubit;

  setUpAll(() => registerFallbackValue(StackTrace.empty));

  setUp(() {
    crashReports = _MockCrashReportService();
    when(() => crashReports.recordError(any<dynamic>(), any())).thenAnswer((_) async {});
    observer = BlocErrorObserver(crashReportService: crashReports);
    cubit = _Counter();
  });

  tearDown(() => cubit.close());

  test('an expected error is not reported', () {
    observer.onError(cubit, const LocalizedException(l10nKey: 'NOT_PAIRED'), StackTrace.empty);

    verifyNever(() => crashReports.recordError(any<dynamic>(), any()));
  });

  test('an unexpected error is reported with its stack', () {
    final error = StateError('broken');

    observer.onError(cubit, error, StackTrace.empty);

    verify(() => crashReports.recordError(error, StackTrace.empty)).called(1);
  });

  test('a failure that wraps a server message reports only its type and code', () {
    final error = ServerResponseException('validation-failed', Exception('email ana@example.com'));

    observer.onError(cubit, error, StackTrace.empty);

    final reported = verify(() => crashReports.recordError(captureAny<dynamic>(), any()))
        .captured
        .single;
    expect(reported.toString(), contains('ServerResponseException validation-failed'));
    expect(reported.toString(), isNot(contains('ana@example.com')));
  });

  ParallelWaitError<dynamic, dynamic> waitFailedWith(Object error) =>
      ParallelWaitError<dynamic, dynamic>(null, [AsyncError(error, StackTrace.empty), null]);

  test('a failure inside a parallel wait is judged and reported as the failure it holds', () {
    final wait = waitFailedWith(
      ServerResponseException('validation-failed', Exception('email ana@example.com')),
    );

    observer.onError(cubit, wait, StackTrace.empty);

    final reported = verify(() => crashReports.recordError(captureAny<dynamic>(), any()))
        .captured
        .single;
    expect(reported.toString(), contains('ServerResponseException validation-failed'));
    expect(reported.toString(), isNot(contains('ana@example.com')));
  });

  test('a parallel wait holding an expected failure is not reported', () {
    observer.onError(
      cubit,
      waitFailedWith(const LocalizedException(l10nKey: 'NETWORK')),
      StackTrace.empty,
    );

    verifyNever(() => crashReports.recordError(any<dynamic>(), any()));
  });

  test('a parallel wait whose failure cannot be read is reported without its details', () {
    final wait = ParallelWaitError<dynamic, dynamic>(null, (
      null,
      null,
      null,
      null,
      null,
      null,
      AsyncError(StateError('email ana@example.com'), StackTrace.empty),
    ));

    observer.onError(cubit, wait, StackTrace.empty);

    final reported = verify(() => crashReports.recordError(captureAny<dynamic>(), any()))
        .captured
        .single;
    expect(reported.toString(), contains('ParallelWaitError'));
    expect(reported.toString(), isNot(contains('ana@example.com')));
  });
}
