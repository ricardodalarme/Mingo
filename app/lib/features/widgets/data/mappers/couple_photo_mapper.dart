import 'package:app/features/widgets/data/data_sources/remote/queries/generated/CouplePhoto.graphql.dart';
import 'package:app/features/widgets/data/models/couple_photo.dart';

extension CouplePhotoNodeMapper on QueryCouplePhotocoupleMembersByPkcouplephoto {
  CouplePhoto toModel({String? url}) => CouplePhoto(
    coupleId: coupleId,
    fileId: fileId,
    uploadedBy: uploadedBy,
    updatedAt: updatedAt,
    url: url,
  );
}
