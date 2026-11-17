import 'dart:convert';

import 'package:app/features/chat/data/data_sources/remote/dtos/chat_event_dto.dart';
import 'package:app/features/chat/data/data_sources/remote/dtos/chat_request_dto.dart';
import 'package:app/features/chat/data/data_sources/remote/queries/generated/ChatStatus.graphql.dart';
import 'package:network/network.dart';

/// What the server knows before the first message.
typedef ChatSettings = ({int messagesLeft, int plusLimit, int freeLimit});

class ChatDataSource({
  required final GQLClient _client,
  required final RestClient _restClient,
  required final String _functionUrl,
}) {
  Future<ChatSettings> getStatus(String profileId) async {
    final response = await _client.query(
      OptionsQueryChatStatus(
        variables: VariablesQueryChatStatus(userId: profileId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => (
        messagesLeft: data.plusStates.firstOrNull?.chatMessagesLeftToday ?? 0,
        plusLimit: int.tryParse(data.plusLimit?.value ?? '') ?? 0,
        freeLimit: int.tryParse(data.freeLimit?.value ?? '') ?? 0,
      ),
    );
  }

  /// Sends [request] and streams the reply; the stream ends when the server closes it.
  Stream<ChatEventDto> send({required ChatRequestDto request}) async* {
    final lines = _restClient.postLines(_functionUrl, data: request.toMap());
    await for (final line in lines) {
      final event = parseChatLine(line);
      if (event != null) yield event;
    }
  }
}

/// Reads one line of the stream: a `data:` event, or a plain JSON error body.
ChatEventDto? parseChatLine(String line) {
  final text = line.trim();
  if (text.isEmpty) return null;
  final raw = text.startsWith('data:') ? text.substring(5).trim() : text;
  try {
    final json = jsonDecode(raw);

    return json is Map<String, Object?> ? ChatEventDto.fromMap(json) : null;
  } on FormatException {
    return null;
  }
}
