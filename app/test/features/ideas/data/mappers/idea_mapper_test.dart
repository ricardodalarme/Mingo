import 'package:app/features/ideas/data/mappers/idea_mapper.dart';
import 'package:app/features/today/data/data_sources/remote/queries/generated/DailyIdeas.graphql.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an idea keeps its slug, title, text and tags', () {
    final idea = QueryDailyIdeascontentItems(
      slug: 'bilhete',
      title: 'Deixe um bilhete',
      body: 'Pequeno e específico.',
      tags: ['carinho', 'rápido'],
    ).toModel();

    expect(idea.slug, 'bilhete');
    expect(idea.title, 'Deixe um bilhete');
    expect(idea.body, 'Pequeno e específico.');
    expect(idea.tags, ['carinho', 'rápido']);
  });

  test('an idea with no text or tags has none', () {
    final idea = QueryDailyIdeascontentItems(slug: 's', title: 't', tags: []).toModel();

    expect(idea.body, isNull);
    expect(idea.tags, isEmpty);
  });
}
