import 'package:app/features/partner/data/data_sources/remote/queries/generated/PartnerFacts.graphql.dart';
import 'package:app/features/partner/data/mappers/partner_fact_category_mapper.dart';
import 'package:app/features/partner/data/models/partner_fact.dart';

extension PartnerFactMapper on QueryPartnerFactspartnerFacts {
  PartnerFact toModel() =>
      PartnerFact(id: id, label: label, value: value, category: category?.toModel());
}
