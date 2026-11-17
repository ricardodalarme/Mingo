import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/together/data/data_sources/remote/queries/generated/DateIdeaSuggestions.graphql.dart';
import 'package:app/features/together/data/data_sources/remote/queries/generated/DateIdeas.graphql.dart';
import 'package:app/features/together/data/mappers/date_idea_mapper.dart';
import 'package:app/features/together/data/models/date_idea_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a saved idea keeps its status and planned day', () {
    final planned = DateTime.utc(2026, 5, 1);
    final idea = QueryDateIdeassavedDateIdeas(
      id: 'd1',
      title: 'Piquenique',
      status: EnumDateIdeaStatus_enum.planned,
      plannedFor: planned,
    ).toModel();

    expect(idea.id, 'd1');
    expect(idea.title, 'Piquenique');
    expect(idea.status, DateIdeaStatus.planned);
    expect(idea.plannedFor, planned);
  });

  test('an idea with no plan has no day', () {
    final idea = QueryDateIdeassavedDateIdeas(
      id: 'd1',
      title: 'Piquenique',
      status: EnumDateIdeaStatus_enum.saved,
    ).toModel();

    expect(idea.plannedFor, isNull);
    expect(idea.status, DateIdeaStatus.saved);
  });

  test('an editorial suggestion keeps its slug and title', () {
    final suggestion = QueryDateIdeaSuggestionscontentItems(
      slug: 'cine',
      title: 'Cinema',
    ).toModel();

    expect(suggestion.slug, 'cine');
    expect(suggestion.title, 'Cinema');
  });
}
