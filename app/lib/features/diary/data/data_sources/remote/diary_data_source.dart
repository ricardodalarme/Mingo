import 'package:app/features/diary/data/data_sources/remote/mutations/generated/DeleteJournalEntry.graphql.dart';
import 'package:app/features/diary/data/data_sources/remote/mutations/generated/InsertJournalEntry.graphql.dart';
import 'package:app/features/diary/data/data_sources/remote/mutations/generated/UpdateJournalEntry.graphql.dart';
import 'package:app/features/diary/data/data_sources/remote/queries/generated/JournalEntries.graphql.dart';
import 'package:network/network.dart';

typedef JournalEntryRecord = ({String id, DateTime entryDate, String body, String? mood});

class DiaryDataSource({required final GQLClient _client}) {
  Future<List<JournalEntryRecord>> getEntries() async {
    final response = await _client.query(
      OptionsQueryJournalEntries(fetchPolicy: FetchPolicy.networkOnly),
    );
    final data = validateResponseData<QueryJournalEntries, QueryJournalEntries>(response);

    return [
      for (final node in data.journalEntries)
        (id: node.id, entryDate: node.entryDate, body: node.body, mood: node.mood),
    ];
  }

  Future<JournalEntryRecord> insertEntry({
    required DateTime entryDate,
    required String body,
    String? mood,
  }) async {
    final response = await _client.mutate(
      OptionsMutationInsertJournalEntry(
        variables: VariablesMutationInsertJournalEntry(
          entryDate: entryDate,
          body: body,
          mood: mood,
        ),
      ),
    );
    final node = validateResponseData(response, getData: (data) => data.insertJournalEntriesOne);

    return (id: node.id, entryDate: node.entryDate, body: node.body, mood: node.mood);
  }

  Future<void> updateEntry({required String id, required String body, String? mood}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateJournalEntry(
        variables: VariablesMutationUpdateJournalEntry(id: id, body: body, mood: mood),
      ),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.updateJournalEntries?.affected_rows ?? 0,
    );
    if (affected == 0) throw const NoDataException();
  }

  Future<void> deleteEntry(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteJournalEntry(variables: VariablesMutationDeleteJournalEntry(id: id)),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.deleteJournalEntries?.affected_rows ?? 0,
    );
    if (affected == 0) throw const NoDataException();
  }
}
