import 'package:app/features/games/data/mappers/game_item_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an item keeps its slug, title and body', () {
    final item = (slug: 'a', title: 'Quem lava a louça?', body: 'Eu ou você').toModel();

    expect(item.slug, 'a');
    expect(item.title, 'Quem lava a louça?');
    expect(item.body, 'Eu ou você');
  });

  test('an item may have no body', () {
    expect((slug: 'a', title: 'Título', body: null).toModel().body, isNull);
  });
}
