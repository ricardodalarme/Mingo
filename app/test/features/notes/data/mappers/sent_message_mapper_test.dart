import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/notes/data/data_sources/remote/queries/generated/SentPartnerMessages.graphql.dart';
import 'package:app/features/notes/data/mappers/sent_message_mapper.dart';
import 'package:app/features/notes/data/models/sent_message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final created = DateTime.utc(2026, 3, 8);

  QuerySentPartnerMessagespartnerMessages node({
    EnumPartnerMessageKind_enum kind = EnumPartnerMessageKind_enum.note,
    String? body = 'Bom dia',
    String? mediaFileId,
  }) => QuerySentPartnerMessagespartnerMessages(
    id: 'm1',
    kind: kind,
    body: body,
    mediaFileId: mediaFileId,
    createdAt: created,
  );

  test('a note keeps its text and day', () {
    final message = node().toModel();

    expect(message.id, 'm1');
    expect(message.kind, MessageKind.note);
    expect(message.body, 'Bom dia');
    expect(message.createdAt, created);
    expect(message.imageUrl, isNull);
  });

  test('a drawing keeps its file and gets the link it is given', () {
    final message = node(
      kind: EnumPartnerMessageKind_enum.drawing,
      body: null,
      mediaFileId: 'file-1',
    ).toModel(imageUrl: 'https://files.example/file-1');

    expect(message.kind, MessageKind.drawing);
    expect(message.mediaFileId, 'file-1');
    expect(message.imageUrl, 'https://files.example/file-1');
  });
}
