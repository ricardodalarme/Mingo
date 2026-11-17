import 'package:app/features/capsules/data/data_sources/remote/queries/generated/Capsules.graphql.dart';
import 'package:app/features/capsules/data/models/capsule.dart';

extension CapsuleMapper on QueryCapsulescapsules {
  /// The capsule as [userId] sees it on [today]: the text stays hidden until the day it opens.
  Capsule toModel({required String? userId, required DateTime today}) => Capsule(
    id: id,
    opensOn: opensOn,
    isMine: authorId == userId,
    isShared: coupleId != null,
    body: DateTime(opensOn.year, opensOn.month, opensOn.day).isAfter(today) ? null : body,
  );
}
