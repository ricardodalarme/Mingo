import 'dart:math';

import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;
import 'package:network/network.dart' hide Response;

Request queryRequest([Map<String, dynamic> variables = const {}]) => Request(
  operation: Operation(document: parseString('query Probe { a }'), operationName: 'Probe'),
  variables: variables,
);

Request mutationRequest([Map<String, dynamic> variables = const {}]) => Request(
  operation: Operation(document: parseString('mutation Probe { a }'), operationName: 'Probe'),
  variables: variables,
);

Request subscriptionRequest([Map<String, dynamic> variables = const {}]) => Request(
  operation: Operation(document: parseString('subscription Probe { a }'), operationName: 'Probe'),
  variables: variables,
);

Response okResponse([Object? value = 1]) => Response(data: {'a': value}, response: const {});

HttpLinkServerException httpError(int status, {Map<String, String> headers = const {}}) =>
    HttpLinkServerException(
      response: http.Response('', status, headers: headers),
      parsedResponse: const Response(response: {}),
      statusCode: status,
    );

ServerException transportError() => ServerException(originalException: Exception('offline'));

Link terminating(Stream<Response> Function(Request request) handler) =>
    Link.function((request, [forward]) => handler(request));

class NoJitter() implements Random {
  @override
  bool nextBool() => false;

  @override
  double nextDouble() => 0;

  @override
  int nextInt(int max) => 0;
}

Future<Object?> failureOf(Stream<Response> stream) async {
  try {
    await stream.first;
  } on Object catch (error) {
    return error;
  }

  return null;
}

/// Stands in for the session: hands out [current] and decides how each renewal ends, recording
/// the token it was asked to replace.
class FakeSession({var String? current, var Future<bool> Function(String? rejected)? onRenew}) {
  final List<String?> renewals = [];

  Future<String?> token() async => current;

  Future<bool> renew(String? rejected) async {
    renewals.add(rejected);

    return onRenew == null ? true : onRenew!(rejected);
  }
}

String? authorizationOf(Request request) =>
    request.context.entry<HttpLinkHeaders>()?.headers['Authorization'];
