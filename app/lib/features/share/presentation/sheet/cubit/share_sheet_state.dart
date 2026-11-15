part of 'share_sheet_cubit.dart';

final class const ShareSheetState({
  final int selectedIndex = 0,
  final Resource<void> shareAction = const Initial(),
}) with Equatable {
  ShareSheetState copyWith({int? selectedIndex, Resource<void>? shareAction}) => ShareSheetState(
    selectedIndex: selectedIndex ?? this.selectedIndex,
    shareAction: shareAction ?? this.shareAction,
  );

  @override
  List<Object?> get props => [selectedIndex, shareAction];
}
