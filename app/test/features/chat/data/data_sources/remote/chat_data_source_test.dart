import 'package:app/features/chat/data/data_sources/remote/chat_data_source.dart';
import 'package:app/features/chat/data/data_sources/remote/queries/generated/ChatStatus.graphql.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockGQLClient() extends Mock implements GQLClient;

class _MockRestClient() extends Mock implements RestClient;

void main() {
  late GQLClient client;
  late ChatDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(OptionsQueryChatStatus(variables: VariablesQueryChatStatus(userId: 'x')));
  });

  setUp(() {
    client = _MockGQLClient();
    dataSource = ChatDataSource(
      client: client,
      restClient: _MockRestClient(),
      functionUrl: 'https://example.test/chat',
    );
  });

  void answerWith(Map<String, dynamic> data) {
    when(() => client.query<QueryChatStatus>(any())).thenAnswer(
      (invocation) async => QueryResult<QueryChatStatus>(
        options: invocation.positionalArguments.first as QueryOptions<QueryChatStatus>,
        source: QueryResultSource.network,
        data: {...data, '__typename': 'Query'},
      ),
    );
  }

  Map<String, dynamic> config(String value) => {'value': value, '__typename': 'AppConfig'};

  test('reads the per-day limits from the two config rows', () async {
    answerWith({
      'plusStates': [
        {'chatMessagesLeftToday': 7, '__typename': 'PlusStates'},
      ],
      'plusLimit': config('30'),
      'freeLimit': config('5'),
    });

    final status = await dataSource.getStatus('p1');

    expect(status.messagesLeft, 7);
    expect(status.plusLimit, 30);
    expect(status.freeLimit, 5);
  });

  test('a missing config row or an unreadable value reads as 0', () async {
    answerWith({'plusStates': <Object?>[], 'plusLimit': null, 'freeLimit': config('many')});

    final status = await dataSource.getStatus('p1');

    expect(status.messagesLeft, 0);
    expect(status.plusLimit, 0);
    expect(status.freeLimit, 0);
  });
}
