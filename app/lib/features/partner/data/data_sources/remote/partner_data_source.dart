import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/partner/data/data_sources/remote/mutations/generated/AddPartnerFact.graphql.dart';
import 'package:app/features/partner/data/data_sources/remote/mutations/generated/DeletePartnerFact.graphql.dart';
import 'package:app/features/partner/data/data_sources/remote/queries/generated/PartnerFacts.graphql.dart';
import 'package:network/network.dart';

class PartnerDataSource({required final GQLClient _client}) {
  Future<List<QueryPartnerFactspartnerFacts>> getFacts() async {
    final response = await _client.query(
      OptionsQueryPartnerFacts(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response, getData: (data) => data.partnerFacts);
  }

  Future<void> addFact({
    required String id,
    required String label,
    required String value,
    EnumPartnerFactCategory_enum? category,
  }) async {
    final response = await _client.mutate(
      OptionsMutationAddPartnerFact(
        variables: VariablesMutationAddPartnerFact(
          id: id,
          label: label,
          value: value,
          category: category,
        ),
      ),
    );

    validateResponse(response);
  }

  Future<void> deleteFact(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeletePartnerFact(variables: VariablesMutationDeletePartnerFact(id: id)),
    );

    validateResponse(response);
  }
}
