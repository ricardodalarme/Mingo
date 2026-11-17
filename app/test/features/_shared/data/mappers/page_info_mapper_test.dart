import 'package:app/features/_shared/data/mappers/page_info_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String label(int row) => 'row $row';

  test('holds the first rows and says another page follows when the read had more', () {
    final page = [1, 2, 3].toPageInfo(offset: 0, pageSize: 2, map: label);

    expect(page.items, ['row 1', 'row 2']);
    expect(page.hasNext, isTrue);
    expect(page.offset, 2);
  });

  test('the last page has no next one and the offset moves past the rows kept', () {
    final page = [1, 2].toPageInfo(offset: 20, pageSize: 2, map: label);

    expect(page.hasNext, isFalse);
    expect(page.offset, 22);
  });

  test('an empty read is an empty page that stays at its offset', () {
    final page = <int>[].toPageInfo(offset: 6, pageSize: 20, map: label);

    expect(page.items, isEmpty);
    expect(page.hasNext, isFalse);
    expect(page.offset, 6);
  });
}
