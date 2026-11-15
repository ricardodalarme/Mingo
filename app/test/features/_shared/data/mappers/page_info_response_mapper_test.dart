import 'package:app/features/_shared/data/data_sources/remote/fragments/generated/PageInfoFragment.graphql.dart';
import 'package:app/features/_shared/data/mappers/page_info_response_mapper.dart';
import 'package:app/features/_shared/data/models/page_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('copies the cursors and both page flags', () {
    final info = FragmentPageInfoFragment(
      hasNextPage: true,
      hasPreviousPage: false,
      startCursor: 'a',
      endCursor: 'b',
    ).toModel();

    expect(
      info,
      const PageInfo(startCursor: 'a', endCursor: 'b', hasNextPage: true, hasPreviousPage: false),
    );
  });

  test('keeps a missing cursor missing', () {
    final info = FragmentPageInfoFragment(hasNextPage: false, hasPreviousPage: false).toModel();

    expect(info.startCursor, isNull);
    expect(info.endCursor, isNull);
  });
}
