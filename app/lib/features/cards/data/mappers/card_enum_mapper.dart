import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/cards/data/models/card_status.dart';

extension EnumCardStatusMapper on EnumCardStatus_enum {
  CardStatus? toModel() => switch (this) {
    EnumCardStatus_enum.draft => CardStatus.draft,
    EnumCardStatus_enum.held => CardStatus.held,
    EnumCardStatus_enum.sent => CardStatus.sent,
    EnumCardStatus_enum.$unknown => null,
  };
}
