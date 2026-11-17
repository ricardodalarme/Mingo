import 'package:app/features/cards/data/data_sources/remote/fragments/generated/CardFragment.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/mutations/generated/PrepareCard.graphql.dart';
import 'package:app/features/cards/data/mappers/card_enum_mapper.dart';
import 'package:app/features/cards/data/models/card_status.dart';
import 'package:app/features/cards/data/models/sunday_card.dart';
import 'package:app/features/slips/data/mappers/slip_enum_mapper.dart';
import 'package:app/features/slips/data/models/slip_category.dart';

extension CardFragmentMapper on FragmentCardFragment {
  SundayCard toModel() => SundayCard(
    id: id,
    status: status.toModel() ?? CardStatus.draft,
    weekStart: weekStart,
    note: note,
    sentAt: sentAt,
    heldReason: heldReason?.toModel(),
    items: [
      for (final item in items)
        CardItem(
          id: item.id,
          body: item.body,
          slipId: item.slipId,
          category: item.slip?.category?.toModel(),
          writtenAt: item.slip?.createdAt,
        ),
    ],
  );
}

extension PreparedCardMapper on MutationPrepareCardprepareCard {
  SundayCard toModel() => SundayCard(
    id: cardId,
    status: status.toModel() ?? CardStatus.draft,
    weekStart: weekStart,
    note: note,
    items: [
      for (final item in (items as List<dynamic>? ?? const []).cast<Map<String, dynamic>>())
        CardItem(
          id: item['id'] as String,
          body: item['body'] as String,
          category: _category(item['category']),
          writtenAt: item['writtenAt'] == null ? null : DateTime.parse(item['writtenAt'] as String),
        ),
    ],
  );
}

SlipCategory? _category(Object? value) =>
    value is String ? SlipCategory.values.where((kind) => kind.name == value).firstOrNull : null;
