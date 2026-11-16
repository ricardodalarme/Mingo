import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/mutations/generated/AddGiftIdea.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/mutations/generated/AddImportantDate.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/mutations/generated/DeleteGiftIdea.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/mutations/generated/DeleteImportantDate.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/mutations/generated/SetGiftIdeaStatus.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/queries/generated/GiftIdeas.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/queries/generated/Holidays.graphql.dart';
import 'package:app/features/dates/data/data_sources/remote/queries/generated/ImportantDates.graphql.dart';
import 'package:network/network.dart';

class DatesDataSource({required final GQLClient _client}) {
  Future<List<QueryImportantDatesimportantDates>> getDates() async {
    final response = await _client.query(
      OptionsQueryImportantDates(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response, getData: (data) => data.importantDates);
  }

  Future<void> addDate({
    required String id,
    required String title,
    required EnumImportantDateKind_enum kind,
    required int month,
    required int day,
    required bool yearly,
    required List<int> remindDays,
    required EnumImportantDateOrigin_enum origin,
    int? year,
    String? holidayKey,
    String? coupleId,
  }) async {
    final response = await _client.mutate(
      OptionsMutationAddImportantDate(
        variables: VariablesMutationAddImportantDate(
          id: id,
          title: title,
          kind: kind,
          month: month,
          day: day,
          year: year,
          yearly: yearly,
          remindDays: remindDays,
          origin: origin,
          holidayKey: holidayKey,
          coupleId: coupleId,
        ),
      ),
    );

    validateResponse(response);
  }

  Future<void> deleteDate(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteImportantDate(variables: VariablesMutationDeleteImportantDate(id: id)),
    );

    validateResponse(response);
  }

  Future<List<QueryGiftIdeasgiftIdeas>> getGiftIdeas() async {
    final response = await _client.query(
      OptionsQueryGiftIdeas(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response, getData: (data) => data.giftIdeas);
  }

  Future<void> addGiftIdea({required String id, required String title}) async {
    final response = await _client.mutate(
      OptionsMutationAddGiftIdea(
        variables: VariablesMutationAddGiftIdea(id: id, title: title),
      ),
    );

    validateResponse(response);
  }

  Future<void> setGiftIdeaStatus({
    required String id,
    required EnumGiftIdeaStatus_enum status,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSetGiftIdeaStatus(
        variables: VariablesMutationSetGiftIdeaStatus(id: id, status: status),
      ),
    );

    validateResponse(response);
  }

  Future<void> deleteGiftIdea(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteGiftIdea(variables: VariablesMutationDeleteGiftIdea(id: id)),
    );

    validateResponse(response);
  }

  Future<List<QueryHolidayscontentItems>> getHolidays(String locale) async {
    final response = await _client.query(
      OptionsQueryHolidays(variables: VariablesQueryHolidays(locale: locale)),
    );

    return validateResponseData(response, getData: (data) => data.contentItems);
  }
}
