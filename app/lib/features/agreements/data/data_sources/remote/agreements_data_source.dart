import 'package:app/features/agreements/data/data_sources/remote/fragments/generated/AgreementFragment.graphql.dart';
import 'package:app/features/agreements/data/data_sources/remote/mutations/generated/AddAgreement.graphql.dart';
import 'package:app/features/agreements/data/data_sources/remote/mutations/generated/ArchiveAgreement.graphql.dart';
import 'package:app/features/agreements/data/data_sources/remote/mutations/generated/ConfirmAgreement.graphql.dart';
import 'package:app/features/agreements/data/data_sources/remote/queries/generated/Agreements.graphql.dart';
import 'package:network/network.dart';

class AgreementsDataSource({required final GQLClient _client}) {
  Future<List<FragmentAgreementFragment>> getAgreements() async {
    final response = await _client.query(
      OptionsQueryAgreements(fetchPolicy: FetchPolicy.networkOnly),
    );

    return List<FragmentAgreementFragment>.of(
      validateResponseData(response, getData: (data) => data.agreements),
    );
  }

  Future<FragmentAgreementFragment> addAgreement({
    required String id,
    required String body,
    String? coupleId,
  }) async {
    final response = await _client.mutate(
      OptionsMutationAddAgreement(
        variables: VariablesMutationAddAgreement(id: id, body: body, coupleId: coupleId),
      ),
    );

    return validateResponseData(response, getData: (data) => data.insertAgreementsOne);
  }

  Future<FragmentAgreementFragment> confirmAgreement(String id) async {
    final response = await _client.mutate(
      OptionsMutationConfirmAgreement(variables: VariablesMutationConfirmAgreement(id: id)),
    );

    return validateResponseData(response, getData: (data) => data.confirmAgreement.firstOrNull);
  }

  Future<void> archiveAgreement({required String id, required DateTime archivedAt}) async {
    final response = await _client.mutate(
      OptionsMutationArchiveAgreement(
        variables: VariablesMutationArchiveAgreement(id: id, archivedAt: archivedAt),
      ),
    );

    validateResponse(response);
  }
}
