import 'package:app/features/slips/data/data_sources/remote/queries/generated/JarSlips.graphql.dart';
import 'package:app/features/slips/data/mappers/drawn_slip_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a jar slip keeps its id and text', () {
    final slip = QueryJarSlipsslips(id: 'j1', body: 'Ouviu até o fim').toModel();

    expect(slip.id, 'j1');
    expect(slip.body, 'Ouviu até o fim');
  });
}
