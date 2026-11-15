import 'package:app/features/cycle/data/data_sources/remote/mutations/generated/MarkSensitiveDay.graphql.dart';
import 'package:app/features/cycle/data/data_sources/remote/mutations/generated/UnmarkSensitiveDay.graphql.dart';
import 'package:app/features/cycle/data/data_sources/remote/queries/generated/SensitiveDays.graphql.dart';
import 'package:network/network.dart';

/// The server's local day and the days the person marked as sensitive.
typedef SensitiveDaysRecord = ({DateTime today, List<DateTime> days});

class CycleDataSource({required final GQLClient _client}) {
  Future<SensitiveDaysRecord> getSensitiveDays() async {
    final response = await _client.query(
      OptionsQuerySensitiveDays(fetchPolicy: FetchPolicy.networkOnly),
    );
    final data = validateResponseData<QuerySensitiveDays, QuerySensitiveDays>(response);
    final today = data.today?.localDate;
    if (today == null) throw const NoDataException();

    return (today: today, days: [for (final edge in data.cycleDaysCollection.edges) edge.node.day]);
  }

  Future<void> markDay(DateTime day) async {
    final response = await _client.mutate(
      OptionsMutationMarkSensitiveDay(variables: VariablesMutationMarkSensitiveDay(day: day)),
    );

    validateResponse(response);
  }

  Future<void> unmarkDay(DateTime day) async {
    final response = await _client.mutate(
      OptionsMutationUnmarkSensitiveDay(variables: VariablesMutationUnmarkSensitiveDay(day: day)),
    );

    validateResponse(response);
  }
}
