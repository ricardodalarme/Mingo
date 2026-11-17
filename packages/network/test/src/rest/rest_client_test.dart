import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:network/network.dart' hide Response;
import 'package:test/test.dart';

import '../../helpers/link_helpers.dart';

/// Answers each request with the next status, and keeps the requests it saw.
class _Server({required final List<int> _statuses}) implements HttpClientAdapter {
  final List<RequestOptions> seen = [];
  final List<String?> authorizations = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    seen.add(options);
    authorizations.add(options.headers['authorization'] as String?);
    final status =
        _statuses[seen.length > _statuses.length ? _statuses.length - 1 : seen.length - 1];

    return ResponseBody.fromString(
      jsonEncode({'status': status}),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late FakeSession session;

  setUp(() => session = FakeSession(current: 'old'));

  RestClient build(_Server server) => RestClientImpl(
    baseUrl: 'https://functions.test',
    tokenCallback: session.token,
    refreshSession: session.renew,
    adapter: server,
  );

  test('sends the access token with each request', () async {
    final server = _Server(statuses: [200]);

    await build(server).get<Object?>('/ping');

    expect(server.authorizations, ['Bearer old']);
  });

  test('keeps an authorization header the caller set', () async {
    final server = _Server(statuses: [200]);

    await build(server).post<Object?>('/ping', headers: {'authorization': 'Bearer custom'});

    expect(server.authorizations, ['Bearer custom']);
  });

  test('sends no authorization header when signed out, and never renews', () async {
    session.current = null;
    final server = _Server(statuses: [401]);

    await expectLater(build(server).get<Object?>('/ping'), throwsA(isA<DioException>()));

    expect(server.authorizations, [null]);
    expect(session.renewals, isEmpty);
  });

  test('sends the token with a streamed request too', () async {
    final server = _Server(statuses: [200]);

    await build(server).postLines('/chat', data: {}).toList();

    expect(server.authorizations, ['Bearer old']);
  });

  group('when the server answers 401', () {
    test('renews the session and sends the request again with the new token', () async {
      session.onRenew = (_) async {
        session.current = 'new';

        return true;
      };
      final server = _Server(statuses: [401, 200]);

      final response = await build(server).get<Map<String, dynamic>>('/ping');

      expect(response.data, {'status': 200});
      expect(server.authorizations, ['Bearer old', 'Bearer new']);
      expect(session.renewals, ['old']);
    });

    test('fails with the 401 when the session cannot be renewed', () async {
      session.onRenew = (_) async => false;
      final server = _Server(statuses: [401]);

      await expectLater(
        build(server).get<Object?>('/ping'),
        throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'status', 401)),
      );

      expect(server.seen, hasLength(1));
    });

    test('does not loop when the repeated request is rejected again', () async {
      final server = _Server(statuses: [401, 401]);

      await expectLater(build(server).get<Object?>('/ping'), throwsA(isA<DioException>()));

      expect(server.seen, hasLength(2));
      expect(session.renewals, hasLength(1));
    });

    test('passes any other status on without renewing', () async {
      final server = _Server(statuses: [500]);

      await expectLater(
        build(server).get<Object?>('/ping'),
        throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'status', 500)),
      );

      expect(session.renewals, isEmpty);
    });
  });

  test('a client without token callbacks sends no authorization header', () async {
    final server = _Server(statuses: [200]);

    await RestClientImpl(baseUrl: 'https://functions.test', adapter: server).get<Object?>('/ping');

    expect(server.authorizations, [null]);
  });
}
