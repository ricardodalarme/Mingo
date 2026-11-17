import 'package:app/features/together/data/data_sources/remote/queries/generated/DateIdeaSuggestions.graphql.dart';
import 'package:app/features/together/data/data_sources/remote/queries/generated/DateIdeas.graphql.dart';
import 'package:app/features/together/data/mappers/together_enum_mapper.dart';
import 'package:app/features/together/data/models/date_idea.dart';

extension DateIdeaMapper on QueryDateIdeassavedDateIdeas {
  DateIdea toModel() =>
      DateIdea(id: id, title: title, status: status.toModel(), plannedFor: plannedFor);
}

extension DateIdeaSuggestionMapper on QueryDateIdeaSuggestionscontentItems {
  DateIdeaSuggestion toModel() => DateIdeaSuggestion(slug: slug, title: title);
}
