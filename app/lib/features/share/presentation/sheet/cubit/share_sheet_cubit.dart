import 'dart:typed_data';

import 'package:app/features/share/data/repositories/share_image_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'share_sheet_state.dart';

class ShareSheetCubit({required final ShareImageRepository _repository})
    extends Cubit<ShareSheetState> {
  this : super(const ShareSheetState());

  void onSelected(int index) => emit(state.copyWith(selectedIndex: index));

  /// Renders the image through [capture] and opens the share sheet with it.
  Future<void> share(Future<Uint8List> Function() capture) async {
    if (state.shareAction.isLoading) return;

    emit(state.copyWith(shareAction: const Loading()));
    try {
      await _repository.share(await capture());
      emit(state.copyWith(shareAction: const Success(null)));
    } catch (exception) {
      emit(state.copyWith(shareAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(shareAction: const Initial()));
  }
}
