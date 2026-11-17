import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/fragments/generated/CardFragment.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/mutations/generated/PrepareCard.graphql.dart';
import 'package:app/features/cards/data/mappers/card_mapper.dart';
import 'package:app/features/cards/data/models/card_status.dart';
import 'package:app/features/cards/data/models/held_reason.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final weekStart = DateTime(2026, 11, 9);

  test('maps the card and its items in the order the server sent them', () {
    final card = FragmentCardFragment(
      id: 'c1',
      status: EnumCardStatus_enum.sent,
      note: 'Obrigada por esta semana',
      weekStart: weekStart,
      sentAt: DateTime.utc(2026, 11, 15, 10),
      items: [
        FragmentCardFragmentitems(
          id: 'i1',
          slipId: 's1',
          body: 'Fez o café',
          position: 0,
          slip: FragmentCardFragmentitemsslip(
            category: EnumSlipCategory_enum.did,
            createdAt: DateTime.utc(2026, 11, 10, 8),
          ),
        ),
        FragmentCardFragmentitems(id: 'i2', slipId: 's2', body: 'Ouviu', position: 1),
      ],
    ).toModel();

    expect(card.id, 'c1');
    expect(card.status, CardStatus.sent);
    expect(card.note, 'Obrigada por esta semana');
    expect(card.weekStart, weekStart);
    expect(card.sentAt, DateTime.utc(2026, 11, 15, 10));
    expect(card.items.map((item) => item.body), ['Fez o café', 'Ouviu']);
    expect(card.items.first.id, 'i1');
    expect(card.items.first.slipId, 's1');
    expect(card.items.first.category, SlipCategory.did);
    expect(card.items.first.writtenAt, DateTime.utc(2026, 11, 10, 8));
    expect(card.items.last.category, isNull);
    expect(card.items.last.writtenAt, isNull);
  });

  test('a card without items has an empty list, and an item without a slip keeps no slip', () {
    final empty = FragmentCardFragment(
      id: 'c1',
      status: EnumCardStatus_enum.draft,
      weekStart: weekStart,
      items: [],
    ).toModel();
    final orphan = FragmentCardFragment(
      id: 'c1',
      status: EnumCardStatus_enum.draft,
      weekStart: weekStart,
      items: [FragmentCardFragmentitems(id: 'i1', body: 'Sem slip', position: 0)],
    ).toModel();

    expect(empty.items, isEmpty);
    expect(orphan.items.single.slipId, isNull);
  });

  test('an unknown status is read as a draft', () {
    final card = FragmentCardFragment(
      id: 'c1',
      status: EnumCardStatus_enum.$unknown,
      weekStart: weekStart,
      items: [],
    ).toModel();

    expect(card.status, CardStatus.draft);
  });

  test('the prepared card maps its items from the payload', () {
    final card = MutationPrepareCardprepareCard(
      cardId: 'c1',
      kind: EnumCardKind_enum.weekly,
      status: EnumCardStatus_enum.draft,
      weekStart: weekStart,
      note: 'Até domingo',
      items: [
        {'id': 'i1', 'body': 'Fez o café', 'feeling': null, 'position': 1},
        {'id': 'i2', 'body': 'Ouviu', 'feeling': 'calma', 'position': 2},
      ],
    ).toModel();

    expect(card.id, 'c1');
    expect(card.status, CardStatus.draft);
    expect(card.weekStart, weekStart);
    expect(card.note, 'Até domingo');
    expect(card.items.map((item) => item.body), ['Fez o café', 'Ouviu']);
    expect(card.items.map((item) => item.id), ['i1', 'i2']);
  });

  test('a prepared card without items is an empty draft', () {
    final card = MutationPrepareCardprepareCard(
      cardId: 'c1',
      kind: EnumCardKind_enum.weekly,
      status: EnumCardStatus_enum.draft,
      weekStart: weekStart,
      items: <Object?>[],
    ).toModel();

    expect(card.items, isEmpty);
  });

  test('a prepared card item keeps the slip category and written time', () {
    final card = MutationPrepareCardprepareCard(
      cardId: 'c1',
      kind: EnumCardKind_enum.weekly,
      status: EnumCardStatus_enum.draft,
      weekStart: weekStart,
      items: <Object?>[
        {
          'id': 'i1',
          'body': 'made coffee',
          'category': 'said',
          'writtenAt': '2026-01-01T10:00:00Z',
        },
      ],
    ).toModel();

    expect(card.items.single.category, SlipCategory.said);
    expect(card.items.single.writtenAt, DateTime.utc(2026, 1, 1, 10));
  });

  test('a held card keeps the reason its wording was held for', () {
    final card = FragmentCardFragment(
      id: 'c1',
      status: EnumCardStatus_enum.held,
      weekStart: weekStart,
      heldReason: EnumHeldReason_enum.contempt,
      items: const [],
    ).toModel();

    expect(card.heldReason, HeldReason.contempt);
    expect(card.isHeldByRule, isTrue);
  });
}
