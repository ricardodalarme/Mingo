import 'package:app/features/account/data/data_sources/remote/fragments/generated/DeletionRequestFragment.graphql.dart';
import 'package:app/features/account/data/mappers/deletion_request_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a deletion request keeps when it was asked and when everything is erased', () {
    final asked = DateTime.utc(2026, 3, 1);
    final purge = DateTime.utc(2026, 3, 31);

    final request = FragmentDeletionRequestFragment(
      requestedAt: asked,
      purgeAfter: purge,
    ).toModel();

    expect(request.requestedAt, asked);
    expect(request.purgeAfter, purge);
  });
}
