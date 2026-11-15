import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/fragments/generated/CardFragment.graphql.dart';
import 'package:app/features/cards/data/mappers/card_mapper.dart';
import 'package:app/features/cards/data/models/card_status.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final weekStart = DateTime(2026, 11, 9);

  test('maps the card and its items in the order the server sent them', () {
    final card = FragmentCardFragment(
      id: 'c1',
      status: EnumCardStatus.sent,
      note: 'Obrigada por esta semana',
      weekStart: weekStart,
      sentAt: DateTime.utc(2026, 11, 15, 10),
      items: FragmentCardFragmentitems(
        edges: [
          FragmentCardFragmentitemsedges(
            node: FragmentCardFragmentitemsedgesnode(
              slipId: 's1',
              body: 'Fez o café',
              position: 0,
              slip: FragmentCardFragmentitemsedgesnodeslip(
                category: EnumSlipCategory.did,
                createdAt: DateTime.utc(2026, 11, 10, 8),
              ),
            ),
          ),
          FragmentCardFragmentitemsedges(
            node: FragmentCardFragmentitemsedgesnode(slipId: 's2', body: 'Ouviu', position: 1),
          ),
        ],
      ),
    ).toModel();

    expect(card.id, 'c1');
    expect(card.status, CardStatus.sent);
    expect(card.note, 'Obrigada por esta semana');
    expect(card.weekStart, weekStart);
    expect(card.sentAt, DateTime.utc(2026, 11, 15, 10));
    expect(card.items.map((item) => item.body), ['Fez o café', 'Ouviu']);
    expect(card.items.first.category, SlipCategory.did);
    expect(card.items.first.writtenAt, DateTime.utc(2026, 11, 10, 8));
    expect(card.items.last.category, isNull);
    expect(card.items.last.writtenAt, isNull);
  });

  test('a card without items has an empty list, and an item without a slip keeps an empty id', () {
    final empty = FragmentCardFragment(
      id: 'c1',
      status: EnumCardStatus.draft,
      weekStart: weekStart,
    ).toModel();
    final orphan = FragmentCardFragment(
      id: 'c1',
      status: EnumCardStatus.draft,
      weekStart: weekStart,
      items: FragmentCardFragmentitems(
        edges: [
          FragmentCardFragmentitemsedges(
            node: FragmentCardFragmentitemsedgesnode(body: 'Sem slip', position: 0),
          ),
        ],
      ),
    ).toModel();

    expect(empty.items, isEmpty);
    expect(orphan.items.single.slipId, '');
  });

  test('an unknown status is read as a draft', () {
    final card = FragmentCardFragment(
      id: 'c1',
      status: EnumCardStatus.$unknown,
      weekStart: weekStart,
    ).toModel();

    expect(card.status, CardStatus.draft);
  });
}
