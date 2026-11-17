import 'package:core/core.dart';
import 'package:crash_report_service/crash_report_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:network/network.dart';

final RegExp _stableCode = RegExp(r'^[A-Z][A-Z0-9_]+$');

class BlocErrorObserver({required final CrashReportService _crashReportService})
    extends BlocObserver {
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    final cause = error.unwrapParallelWaitError();
    final logger = Logger('${bloc.runtimeType}');
    final description = _describe(cause);

    if (isExpectedError(cause)) {
      logger.info('failed with an expected error: $description');
    } else {
      logger.warning('failed: $description', stackTrace: stackTrace);
      _crashReportService.recordError(_reportable(cause), stackTrace);
    }
    super.onError(bloc, error, stackTrace);
  }

  /// Whether [error] is something the app expects to happen, so it is logged and not reported.
  @visibleForTesting
  bool isExpectedError(Object error) => switch (error) {
    ServerResponseException(:final code) => code != null && _stableCode.hasMatch(code),
    NoDataException() || UnknownException() => false,
    LocalizedException() => true,
    _ => false,
  };

  String _describe(Object error) => error is LocalizedException
      ? '${error.runtimeType} ${error.l10nKey}'
      : '${error.runtimeType}';

  Object _reportable(Object error) => switch (error) {
    LocalizedException() || ParallelWaitError() => Exception(_describe(error)),
    _ => error,
  };
}
