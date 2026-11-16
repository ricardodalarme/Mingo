import 'dart:async';

import 'package:graphql/client.dart';
import 'package:network/network.dart';
import 'package:network/src/graphql/links/timeout_link.dart';
import 'package:test/test.dart';

QueryResult<Object?> _result(OperationException exception) => QueryResult<Object?>(
  options: QueryOptions<Object?>(document: parseString('query { a }')),
  source: QueryResultSource.network,
  exception: exception,
);

void main() {
  test('uses the stable backend code from the error message', () {
    final result = _result(
      OperationException(graphqlErrors: [const GraphQLError(message: 'FREE_LIMIT_REACHED')]),
    );

    expect(mapResponseException(result)?.code, 'FREE_LIMIT_REACHED');
  });

  test('prefers the message over an extension code when it is a stable code', () {
    final result = _result(
      OperationException(
        graphqlErrors: [
          const GraphQLError(message: 'NOT_PAIRED', extensions: {'code': 'P0001'}),
        ],
      ),
    );

    expect(mapResponseException(result)?.code, 'NOT_PAIRED');
  });

  test('reports TIMEOUT when the request limit was reached', () {
    final result = _result(
      OperationException(linkException: const RequestTimeoutException(Duration(seconds: 10))),
    );

    expect(mapResponseException(result)?.code, timeoutErrorCode);
  });

  test('reports NETWORK when the request never reached the server', () {
    final result = _result(
      OperationException(linkException: ServerException(originalException: Exception('down'))),
    );

    expect(mapResponseException(result)?.code, networkErrorCode);
  });

  test('returns null when there is no exception', () {
    final result = QueryResult<Object?>(
      options: QueryOptions<Object?>(document: parseString('query { a }')),
      source: QueryResultSource.network,
    );

    expect(mapResponseException(result), isNull);
  });

  group('mapResponseData', () {
    QueryResult<Map<String, Object?>> data(
      Map<String, Object?>? value, {
      OperationException? error,
    }) => QueryResult<Map<String, Object?>>(
      options: QueryOptions<Map<String, Object?>>(
        document: parseString('query { a }'),
        parserFn: (json) => json,
      ),
      source: QueryResultSource.network,
      data: value,
      exception: error,
    );

    test('maps the data of each result', () async {
      final values = await Stream.fromIterable([
        data({'a': 1}),
        data({'a': 2}),
      ]).mapResponseData((json) => json['a']! as int).toList();

      expect(values, [1, 2]);
    });

    test('turns a failing result into an error and keeps the stream open', () async {
      final events = <Object?>[];
      final done = Completer<void>();
      Stream.fromIterable([
            data(
              null,
              error: OperationException(graphqlErrors: [const GraphQLError(message: 'NOT_PAIRED')]),
            ),
            data({'a': 3}),
          ])
          .mapResponseData((json) => json['a']! as int)
          .listen(events.add, onError: events.add, onDone: done.complete);
      await done.future;

      expect(events.first, isA<ServerResponseException>());
      expect(events.last, 3);
    });

    test('fails with no data when the mapper finds nothing', () {
      final stream = Stream.value(data({'a': 1})).mapResponseData<int>((json) => null);

      expect(stream.first, throwsA(isA<NoDataException>()));
    });
  });
}
