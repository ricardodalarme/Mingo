import 'package:app/features/together/data/data_sources/remote/queries/generated/HelpContent.graphql.dart';
import 'package:app/features/together/data/models/date_idea.dart';

extension HelpItemMapper on QueryHelpContentcontentItems {
  HelpItem toModel() => HelpItem(slug: slug, title: title, body: body);
}
