import 'package:app/features/cards/data/data_sources/remote/fragments/generated/CardFragment.graphql.dart';
import 'package:app/features/cards/data/mappers/card_enum_mapper.dart';
import 'package:app/features/cards/data/models/card_status.dart';
import 'package:app/features/cards/data/models/sunday_card.dart';
import 'package:app/features/slips/data/mappers/slip_enum_mapper.dart';

extension CardFragmentMapper on FragmentCardFragment {
  SundayCard toModel() => SundayCard(
    id: id,
    status: status.toModel() ?? CardStatus.draft,
    weekStart: weekStart,
    note: note,
    sentAt: sentAt,
    items: [
      for (final edge in items?.edges ?? const <FragmentCardFragmentitemsedges>[])
        CardItem(
          slipId: edge.node.slipId ?? '',
          body: edge.node.body,
          category: edge.node.slip?.category?.toModel(),
          writtenAt: edge.node.slip?.createdAt,
        ),
    ],
  );
}
