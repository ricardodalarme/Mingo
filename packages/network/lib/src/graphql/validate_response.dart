import 'package:graphql/client.dart' hide UnknownException;
import 'package:network/src/exceptions/no_data_exception.dart';
import 'package:network/src/exceptions/server_response_exception.dart';
import 'package:network/src/graphql/links/timeout_link.dart';

void validateResponse(QueryResult response) {
  final mapped = mapResponseException(response);
  if (mapped != null) {
    throw mapped;
  }
}

ServerResponseException? mapResponseException(QueryResult response) {
  final exception = response.exception;
  if (exception == null) {
    return null;
  }

  if (exception.linkException != null && exception.graphqlErrors.isEmpty) {
    return ServerResponseException(linkExceptionCode(exception.linkException!), exception);
  }

  final firstError = exception.graphqlErrors.firstOrNull;
  final code = firstError == null ? null : graphQLErrorCode(firstError) ?? firstError.message;

  return ServerResponseException(code, exception);
}

/// A short stable code for a GraphQL error: the code the message is made of or ends with, or the
/// code the server attached. It is never the free text of the message, so it is safe to log.
String? graphQLErrorCode(GraphQLError error) {
  final message = error.message;
  if (_stableCode.hasMatch(message)) return message;

  return _trailingCode(message) ??
      error.extensions?['code']?.toString() ??
      error.extensions?['error_code']?.toString();
}

/// The code for a request that never got an answer: [timeoutErrorCode] or [networkErrorCode].
String linkExceptionCode(Object error) {
  final isTimeout =
      error is RequestTimeoutException || error.toString().toLowerCase().contains('timeout');

  return isTimeout ? timeoutErrorCode : networkErrorCode;
}

/// The code reported when the request never reached the server.
const String networkErrorCode = 'NETWORK';

/// The code reported when the request reached the server too late.
const String timeoutErrorCode = 'TIMEOUT';

final RegExp _stableCode = RegExp(r'^[A-Z][A-Z0-9_]+$');

/// A stable code that ends a longer message, as in `Check constraint violation. NOT_PAIRED`.
final RegExp _trailingStableCode = RegExp(r'\s([A-Z][A-Z0-9_]{2,})$');

String? _trailingCode(String? message) =>
    message == null ? null : _trailingStableCode.firstMatch(message)?.group(1);

D validateResponseData<T, D>(QueryResult<T> response, {D? Function(T data)? getData}) {
  validateResponse(response);

  final parsedData = response.parsedData;
  if (parsedData == null) {
    throw const NoDataException();
  }

  if (getData != null) {
    final data = getData(parsedData);
    if (data == null) {
      throw const NoDataException();
    }
    return data;
  }

  return parsedData as D;
}

/// Streams of results from a subscription or a watched query.
extension QueryResultStreamX<T> on Stream<QueryResult<T>> {
  /// Validates each result and maps its data like [validateResponseData] does for one result.
  ///
  /// A failing result becomes an error event; the stream stays open for the next result.
  Stream<D> mapResponseData<D>(D? Function(T data) getData) =>
      map((result) => validateResponseData<T, D>(result, getData: getData));
}
