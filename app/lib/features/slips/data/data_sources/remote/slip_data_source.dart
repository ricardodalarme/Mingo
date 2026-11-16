import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/mutations/generated/ArchiveSlip.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/mutations/generated/DeleteSlip.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/mutations/generated/SaveSlip.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/mutations/generated/SendSignal.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/mutations/generated/SendSlipNow.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/mutations/generated/SetSlipInJar.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/queries/generated/MySlips.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/queries/generated/SlipDetail.graphql.dart';
import 'package:app/features/slips/data/models/slip_filter.dart';
import 'package:network/network.dart';

/// One slip and whether it already belongs to a card.
typedef SlipRow = ({QuerySlipDetailslipsByPk slip, bool wasInCard});

class SlipDataSource({required final GQLClient _client}) {
  /// Writes the slip; sending the same [id] again updates it instead of failing.
  Future<void> saveSlip({
    required String id,
    required String body,
    required DateTime createdAt,
    EnumSlipKind_enum kind = EnumSlipKind_enum.quick,
    String? feeling,
    String? planNote,
    bool forCard = true,
    EnumSlipCategory_enum? category,
    EnumWorkArea_enum? workArea,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSaveSlip(
        variables: VariablesMutationSaveSlip(
          id: id,
          body: body,
          createdAt: createdAt,
          kind: kind,
          feeling: feeling,
          planNote: planNote,
          forCard: forCard,
          category: category,
          workArea: workArea,
        ),
      ),
    );

    validateResponse(response);
  }

  /// Sends a gentle signal to the partner; fails with `NOT_PAIRED` when there is none.
  Future<void> sendSignal({required EnumSignalKind_enum kind, String? value, String? body}) async {
    final response = await _client.mutate(
      OptionsMutationSendSignal(
        variables: VariablesMutationSendSignal(kind: kind, value: value, body: body),
      ),
    );

    validateResponse(response);
  }

  /// Tells the partner what the person needs, such as a hug or someone to listen.
  Future<void> sendNeed({required String value}) =>
      sendSignal(kind: EnumSignalKind_enum.need, value: value);

  /// Sends the partner a hug, optionally carrying a short [body].
  Future<void> sendHug({String? body}) => sendSignal(kind: EnumSignalKind_enum.hug, body: body);

  /// Reads one page of the person's own slips that match [filter], newest first.
  Future<List<QueryMySlipsslips>> getSlips({
    required int limit,
    required int offset,
    SlipFilter filter = const SlipFilter(),
  }) async {
    final text = filter.text.trim();
    final response = await _client.query(
      OptionsQueryMySlips(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: VariablesQueryMySlips(
          limit: limit,
          offset: offset,
          where: Inputslips_bool_exp(
            archivedAt: Inputtimestamptz_comparison_exp($_is_null: true),
            createdAt: filter.since == null
                ? null
                : Inputtimestamptz_comparison_exp($_gte: filter.since),
            forCard: filter.inCard == null
                ? null
                : InputBoolean_comparison_exp($_eq: filter.inCard),
            kind: filter.onlyInvisible
                ? InputSlipKind_enum_comparison_exp($_eq: EnumSlipKind_enum.invisible)
                : null,
            body: text.isEmpty ? null : InputString_comparison_exp($_ilike: '%$text%'),
          ),
        ),
      ),
    );

    return validateResponseData(response, getData: (data) => data.slips);
  }

  /// Reads one slip of the person, or null when it is gone or not theirs.
  Future<SlipRow?> getSlip(String id) async {
    final response = await _client.query(
      OptionsQuerySlipDetail(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: VariablesQuerySlipDetail(id: id),
      ),
    );
    validateResponse(response);
    final data = response.parsedData;
    final slip = data?.slipsByPk;
    if (data == null || slip == null) return null;

    return (slip: slip, wasInCard: data.cardItems.isNotEmpty);
  }

  Future<void> setInJar({required String id, required bool inJar}) async {
    final response = await _client.mutate(
      OptionsMutationSetSlipInJar(
        variables: VariablesMutationSetSlipInJar(id: id, inJar: inJar),
      ),
    );

    validateResponse(response);
  }

  /// Marks the slip as archived, or takes it back to the timeline.
  Future<void> archiveSlip({required String id, required bool archived}) async {
    final response = await _client.mutate(
      OptionsMutationArchiveSlip(
        variables: VariablesMutationArchiveSlip(
          id: id,
          archivedAt: archived ? DateTime.now().toUtc() : null,
        ),
      ),
    );

    validateResponse(response);
  }

  Future<void> deleteSlip(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteSlip(variables: VariablesMutationDeleteSlip(id: id)),
    );

    validateResponse(response);
  }

  /// Sends one slip to the partner on its own; the status of the card it made, or null when none.
  Future<EnumCardStatus_enum?> sendSlipNow(String slipId) async {
    final response = await _client.mutate(
      OptionsMutationSendSlipNow(variables: VariablesMutationSendSlipNow(slipId: slipId)),
    );
    validateResponse(response);

    return response.parsedData?.sendSlip.firstOrNull?.status;
  }
}
