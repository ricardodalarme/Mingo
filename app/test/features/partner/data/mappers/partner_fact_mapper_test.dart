import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/partner/data/data_sources/remote/queries/generated/PartnerFacts.graphql.dart';
import 'package:app/features/partner/data/mappers/partner_fact_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a note keeps its label, value and category', () {
    final fact = QueryPartnerFactspartnerFacts(
      id: 'f1',
      label: 'Café',
      value: 'Sem açúcar',
      category: EnumPartnerFactCategory_enum.likes,
    ).toModel();

    expect(fact.id, 'f1');
    expect(fact.label, 'Café');
    expect(fact.value, 'Sem açúcar');
    expect(fact.category, isNotNull);
  });

  test('a note with no category has none', () {
    final fact = QueryPartnerFactspartnerFacts(id: 'f1', label: 'Café', value: 'Preto').toModel();

    expect(fact.category, isNull);
  });
}
