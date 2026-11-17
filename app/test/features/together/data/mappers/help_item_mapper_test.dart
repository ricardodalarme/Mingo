import 'package:app/features/together/data/data_sources/remote/queries/generated/HelpContent.graphql.dart';
import 'package:app/features/together/data/mappers/help_item_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a help item keeps its slug, title and text', () {
    final item = QueryHelpContentcontentItems(
      slug: 'respirar',
      title: 'Respire',
      body: 'Devagar',
    ).toModel();

    expect(item.slug, 'respirar');
    expect(item.title, 'Respire');
    expect(item.body, 'Devagar');
  });

  test('a help item with no text has none', () {
    expect(QueryHelpContentcontentItems(slug: 's', title: 't').toModel().body, isNull);
  });
}
