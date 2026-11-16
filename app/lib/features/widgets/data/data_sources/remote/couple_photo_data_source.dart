import 'package:app/features/widgets/data/data_sources/remote/mutations/generated/DeleteCouplePhoto.graphql.dart';
import 'package:app/features/widgets/data/data_sources/remote/mutations/generated/InsertCouplePhoto.graphql.dart';
import 'package:app/features/widgets/data/data_sources/remote/mutations/generated/UpsertCouplePhoto.graphql.dart';
import 'package:app/features/widgets/data/data_sources/remote/queries/generated/CouplePhoto.graphql.dart';
import 'package:app/features/widgets/data/mappers/couple_photo_mapper.dart';
import 'package:app/features/widgets/data/models/couple_photo.dart';
import 'package:network/network.dart';

/// The current couple id and its photo row, read in one round trip.
typedef CouplePhotoSnapshot = ({String? coupleId, CouplePhoto? photo});

class CouplePhotoDataSource({required final GQLClient _client}) {
  Future<CouplePhotoSnapshot> getPhoto(String userId) async {
    final response = await _client.query(
      OptionsQueryCouplePhoto(
        variables: VariablesQueryCouplePhoto(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    return validateResponseData(
      response,
      getData: (data) {
        final couple = data.coupleMembersByPk?.couple;

        return (coupleId: couple?.id, photo: couple?.photo?.toModel());
      },
    );
  }

  /// The number of rows the update touched; `0` means the couple has no row yet.
  Future<int> update({required String coupleId, required String fileId}) async {
    final response = await _client.mutate(
      OptionsMutationUpsertCouplePhoto(
        variables: VariablesMutationUpsertCouplePhoto(coupleId: coupleId, fileId: fileId),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateCouplePhotos?.affected_rows ?? 0,
    );
  }

  Future<int> insert({required String coupleId, required String fileId}) async {
    final response = await _client.mutate(
      OptionsMutationInsertCouplePhoto(
        variables: VariablesMutationInsertCouplePhoto(coupleId: coupleId, fileId: fileId),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.insertCouplePhotos?.affected_rows ?? 0,
    );
  }

  Future<int> delete(String coupleId) async {
    final response = await _client.mutate(
      OptionsMutationDeleteCouplePhoto(
        variables: VariablesMutationDeleteCouplePhoto(coupleId: coupleId),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.deleteCouplePhotos?.affected_rows ?? 0,
    );
  }
}
