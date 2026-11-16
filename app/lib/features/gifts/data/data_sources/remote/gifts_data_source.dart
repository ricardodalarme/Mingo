import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/fragments/generated/GiftWishFragment.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/mutations/generated/AddGiftWish.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/mutations/generated/DeleteGiftWish.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/mutations/generated/SetGiftWishVisibility.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/mutations/generated/UpdateGiftWish.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/queries/generated/GiftPage.graphql.dart';
import 'package:network/network.dart';

class GiftsDataSource({required final GQLClient _client}) {
  Future<List<FragmentGiftWishFragment>> getGiftIdeas() async {
    final response = await _client.query(
      OptionsQueryGiftPage(fetchPolicy: FetchPolicy.networkOnly),
    );

    return List<FragmentGiftWishFragment>.of(
      validateResponseData(response, getData: (data) => data.giftIdeas),
    );
  }

  Future<FragmentGiftWishFragment> addGiftWish({
    required String id,
    required String title,
    String? note,
    EnumGiftBudget_enum? budget,
    String? coupleId,
  }) async {
    final response = await _client.mutate(
      OptionsMutationAddGiftWish(
        variables: VariablesMutationAddGiftWish(
          id: id,
          title: title,
          note: note,
          budget: budget,
          coupleId: coupleId,
        ),
      ),
    );

    return validateResponseData(response, getData: (data) => data.insertGiftIdeasOne);
  }

  /// Saves the details in one request. A null [note] or [budget] clears the value.
  Future<FragmentGiftWishFragment> updateGiftWish({
    required String id,
    required String title,
    String? note,
    EnumGiftBudget_enum? budget,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateGiftWish(
        // fromJson keeps a null in the payload; the generated constructor drops it,
        // which would leave the old note or budget in place.
        variables: VariablesMutationUpdateGiftWish.fromJson({
          'id': id,
          'title': title,
          'note': note,
          'budget': budget?.toJson(),
        }),
      ),
    );

    return validateResponseData(response, getData: (data) => data.updateGiftIdeasByPk);
  }

  Future<void> deleteGiftWish(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteGiftWish(variables: VariablesMutationDeleteGiftWish(id: id)),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.deleteGiftIdeas?.affected_rows,
    );
    if (affected == 0) throw const NoDataException();
  }

  /// Shares the wish with the couple, or makes it private when [coupleId] is null.
  Future<FragmentGiftWishFragment> setGiftWishVisibility({
    required String id,
    String? coupleId,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSetGiftWishVisibility(
        variables: VariablesMutationSetGiftWishVisibility.fromJson({
          'id': id,
          'coupleId': coupleId,
        }),
      ),
    );

    return validateResponseData(response, getData: (data) => data.updateGiftIdeasByPk);
  }
}
