import 'dart:async';

import 'package:graphql/client.dart';
import 'package:logger/logger.dart';
import 'package:network/src/graphql/validate_response.dart';

/// Writes one short line for each GraphQL call: what it was, how it ended and how long it took.
class LoggingLink({final Logger? logger, final Duration slowAfter = const Duration(seconds: 2)})
    extends Link {
  late final Logger _logger = logger ?? Logger('GraphQL');

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    final label = '${_typeOf(request)} ${request.operation.operationName ?? 'anonymous'}';
    final isSubscription = request.isSubscription;
    final stopwatch = Stopwatch()..start();
    var isSettled = false;

    void report(String outcome, {required bool isProblem, String? code}) {
      final time = isSubscription && outcome == 'started'
          ? ''
          : ' ${stopwatch.elapsedMilliseconds}ms';
      final message = '$label $outcome$time${code == null ? '' : ' $code'}';
      if (isProblem) {
        _logger.warning(message);
      } else {
        _logger.debug(message);
      }
    }

    void settleWithResult({required bool isFailure, String? code}) {
      if (isSettled) return;
      isSettled = true;
      if (isFailure) {
        report('failed', isProblem: true, code: code);
      } else if (!isSubscription && stopwatch.elapsed >= slowAfter) {
        report('slow', isProblem: true);
      } else if (!isSubscription) {
        report('ok', isProblem: false);
      }
    }

    if (isSubscription) report('started', isProblem: false);

    return forward!(request).transform(
      StreamTransformer<Response, Response>.fromHandlers(
        handleData: (response, sink) {
          final errors = response.errors;
          if (errors != null && errors.isNotEmpty) {
            settleWithResult(isFailure: true, code: _codeOf(errors));
          } else if (!isSubscription) {
            settleWithResult(isFailure: false);
          }
          sink.add(response);
        },
        handleError: (error, stackTrace, sink) {
          settleWithResult(isFailure: true, code: linkExceptionCode(error));
          sink.addError(error, stackTrace);
        },
        handleDone: (sink) {
          if (isSubscription && !isSettled) {
            isSettled = true;
            report('ended', isProblem: false);
          }
          sink.close();
        },
      ),
    );
  }

  String _typeOf(Request request) => request.isSubscription
      ? 'subscription'
      : request.isMutation
      ? 'mutation'
      : 'query';

  String _codeOf(List<GraphQLError> errors) => graphQLErrorCode(errors.first) ?? 'UNKNOWN';
}
