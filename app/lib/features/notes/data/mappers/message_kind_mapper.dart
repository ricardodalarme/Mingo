import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/notes/data/models/sent_message.dart';

extension EnumPartnerMessageKindMapper on EnumPartnerMessageKind_enum {
  /// Kinds the app cannot show as a drawing are shown as notes.
  MessageKind toModel() => switch (this) {
    EnumPartnerMessageKind_enum.drawing => MessageKind.drawing,
    _ => MessageKind.note,
  };
}

extension MessageKindMapper on MessageKind {
  EnumPartnerMessageKind_enum toRemote() => switch (this) {
    MessageKind.note => EnumPartnerMessageKind_enum.note,
    MessageKind.drawing => EnumPartnerMessageKind_enum.drawing,
  };
}
