import 'package:app/features/widgets/data/data_sources/remote/queries/generated/CouplePhoto.graphql.dart';
import 'package:app/features/widgets/data/mappers/couple_photo_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final node = QueryCouplePhotocoupleMembersByPkcouplephoto(
    coupleId: 'c1',
    fileId: 'file-1',
    uploadedBy: 'u1',
    updatedAt: DateTime.utc(2026, 11, 9, 12),
  );

  test('copies the photo row and has no url until one is signed', () {
    final photo = node.toModel();

    expect(photo.coupleId, 'c1');
    expect(photo.fileId, 'file-1');
    expect(photo.uploadedBy, 'u1');
    expect(photo.updatedAt, DateTime.utc(2026, 11, 9, 12));
    expect(photo.url, isNull);
  });

  test('carries the signed url when one is given', () {
    expect(node.toModel(url: 'https://example.test/signed').url, 'https://example.test/signed');
  });
}
