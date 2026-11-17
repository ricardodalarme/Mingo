import 'package:app/features/account/data/data_sources/remote/account_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockGQLClient() extends Mock implements GQLClient;

class _MockRestClient() extends Mock implements RestClient;

void main() {
  late RestClient rest;
  late AccountDataSource dataSource;

  Response<Map<String, Object?>> ok(Map<String, Object?> body) =>
      Response(requestOptions: RequestOptions(), data: body, statusCode: 200);

  setUp(() {
    rest = _MockRestClient();
    dataSource = AccountDataSource(client: _MockGQLClient(), restClient: rest);
  });

  test('the export sends the token and returns the link', () async {
    when(() => rest.post<Map<String, Object?>>('/export', headers: {'authorization': 'Bearer t'}))
        .thenAnswer((_) async => ok({'url': 'https://files.test/a.json'}));

    expect(await dataSource.exportData(accessToken: 't'), Uri.parse('https://files.test/a.json'));
  });

  test('a limit answer keeps the server code', () async {
    when(() => rest.post<Map<String, Object?>>('/export', headers: any(named: 'headers')))
        .thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {'error': 'EXPORT_LIMIT'},
              statusCode: 429,
            ),
          ),
        );

    await expectLater(
      dataSource.exportData(accessToken: 't'),
      throwsA(isA<ServerResponseException>().having((e) => e.l10nKey, 'l10nKey', 'EXPORT_LIMIT')),
    );
  });
}
