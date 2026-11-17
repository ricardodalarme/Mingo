part of 'export_data_cubit.dart';

final class const ExportDataState({final Resource<Uri> exportAction = const Initial()})
    with Equatable {
  ExportDataState copyWith({Resource<Uri>? exportAction}) =>
      ExportDataState(exportAction: exportAction ?? this.exportAction);

  @override
  List<Object?> get props => [exportAction];
}
