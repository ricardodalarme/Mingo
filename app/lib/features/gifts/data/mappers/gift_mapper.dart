import 'package:app/features/gifts/data/data_sources/remote/fragments/generated/GiftWishFragment.graphql.dart';
import 'package:app/features/gifts/data/mappers/gift_enum_mapper.dart';
import 'package:app/features/gifts/data/models/gift_idea.dart';

extension GiftWishFragmentMapper on FragmentGiftWishFragment {
  GiftIdea toModel({required String? currentUserId}) => GiftIdea(
    id: id,
    title: title,
    note: note,
    link: link,
    status: status.toModel(),
    isMine: authorId == currentUserId,
  );
}
