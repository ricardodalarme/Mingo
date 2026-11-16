import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/notes/data/mappers/message_kind_mapper.dart';
import 'package:app/features/notes/data/models/sent_message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a drawing is a drawing', () {
    expect(EnumPartnerMessageKind_enum.drawing.toModel(), MessageKind.drawing);
  });

  test('every other kind is shown as a note', () {
    expect(EnumPartnerMessageKind_enum.note.toModel(), MessageKind.note);
    expect(EnumPartnerMessageKind_enum.voice.toModel(), MessageKind.note);
    expect(EnumPartnerMessageKind_enum.pack.toModel(), MessageKind.note);
    expect(EnumPartnerMessageKind_enum.$unknown.toModel(), MessageKind.note);
  });

  test('a message kind survives a trip to the remote enum and back', () {
    for (final value in MessageKind.values) {
      expect(value.toRemote().toModel(), value);
    }
  });
}
