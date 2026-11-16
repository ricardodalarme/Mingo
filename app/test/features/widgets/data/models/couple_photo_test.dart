import 'package:app/features/widgets/data/models/couple_photo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CouplePhoto', () {
    test('fake values are placeholders with no signed URL', () {
      final photo = CouplePhoto.fake();

      expect(photo.coupleId, isNotEmpty);
      expect(photo.fileId, isNotEmpty);
      expect(photo.url, isNull);
    });

    test('copyWith keeps the row and adds a signed URL', () {
      final photo = CouplePhoto.fake();
      final withUrl = photo.copyWith(url: 'https://example.test/photo.jpg');

      expect(withUrl.coupleId, photo.coupleId);
      expect(withUrl.fileId, photo.fileId);
      expect(withUrl.url, 'https://example.test/photo.jpg');
    });
  });
}
