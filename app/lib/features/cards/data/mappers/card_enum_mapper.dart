import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/cards/data/models/card_status.dart';

extension EnumCardStatusMapper on EnumCardStatus {
  CardStatus? toModel() => switch (this) {
    EnumCardStatus.draft => CardStatus.draft,
    EnumCardStatus.held => CardStatus.held,
    EnumCardStatus.sent => CardStatus.sent,
    EnumCardStatus.$unknown => null,
  };
}
