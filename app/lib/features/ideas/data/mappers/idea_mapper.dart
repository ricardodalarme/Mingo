import 'package:app/features/ideas/data/models/idea.dart';
import 'package:app/features/today/data/data_sources/remote/queries/generated/DailyIdeas.graphql.dart';

extension IdeaMapper on QueryDailyIdeascontentItems {
  Idea toModel() => Idea(slug: slug, title: title, body: body, tags: List.of(tags));
}
