import 'package:app/features/pairing/data/data_sources/remote/mutations/generated/AcceptInvite.graphql.dart';
import 'package:app/features/pairing/data/data_sources/remote/mutations/generated/CancelInvite.graphql.dart';
import 'package:app/features/pairing/data/data_sources/remote/mutations/generated/CreateInvite.graphql.dart';
import 'package:app/features/pairing/data/data_sources/remote/mutations/generated/ResolveSharedItems.graphql.dart';
import 'package:app/features/pairing/data/data_sources/remote/mutations/generated/Unpair.graphql.dart';
import 'package:app/features/pairing/data/data_sources/remote/queries/generated/MyPartner.graphql.dart';
import 'package:network/network.dart';

class PairingDataSource({required final GQLClient _client}) {
  Future<MutationCreateInviteinsertInvitesOne> createInvite() async {
    final response = await _client.mutate(OptionsMutationCreateInvite());

    return validateResponseData(response, getData: (data) => data.insertInvitesOne);
  }

  /// Returns whether the code connected the two people; the server sends no row for any code
  /// that is unknown, expired, used or the person's own.
  Future<bool> acceptInvite(String code) async {
    final response = await _client.mutate(
      OptionsMutationAcceptInvite(variables: VariablesMutationAcceptInvite(code: code)),
    );
    validateResponse(response);

    return response.parsedData?.acceptInvite.isNotEmpty ?? false;
  }

  /// The partner's profile, or `null` when the person is not paired.
  Future<QueryMyPartnercouplesmembersprofile?> getPartner(String userId) async {
    final response = await _client.query(
      OptionsQueryMyPartner(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: VariablesQueryMyPartner(userId: userId),
      ),
    );
    validateResponse(response);
    final couple = response.parsedData?.couples.firstOrNull;

    return couple?.members.where((member) => member.userId != userId).firstOrNull?.profile;
  }

  /// Cancels an invite that has not been used yet.
  Future<void> cancelInvite(String inviteId) async {
    final response = await _client.mutate(
      OptionsMutationCancelInvite(
        variables: VariablesMutationCancelInvite(
          inviteId: inviteId,
          cancelledAt: DateTime.now().toUtc(),
        ),
      ),
    );

    validateResponse(response);
  }

  /// Ends the couple; the server answers with the caller's profile.
  Future<void> unpair() async {
    final response = await _client.mutate(OptionsMutationUnpair());

    validateResponse(response);
  }

  /// Keeps the person's shared rows or deletes them; the server sends no row while still paired.
  Future<void> resolveSharedItems({required bool keep}) async {
    final response = await _client.mutate(
      OptionsMutationResolveSharedItems(variables: VariablesMutationResolveSharedItems(keep: keep)),
    );

    validateResponse(response);
  }
}
