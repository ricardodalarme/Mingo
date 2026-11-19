part of 'dates_cubit.dart';

final class const DatesState({
  final DatesView view = DatesView.dates,
  final Resource<List<ImportantDate>> dates = const Loading(),
  final Resource<List<Holiday>> holidays = const Loading(),
  final FormInput<String> title = const FormInput(''),
  final ImportantDateKind kind = ImportantDateKind.birthday,
  final int? month,
  final int? day,
  final FormInput<String> year = const FormInput(''),
  final Resource<void> saveAction = const Initial(),
}) with Equatable {
  /// The typed year, or null when it is empty or not a plausible year.
  int? get yearValue {
    final value = int.tryParse(year.value.trim());

    return value != null && value >= 1900 && value <= 2200 ? value : null;
  }

  DatesState copyWith({
    DatesView? view,
    Resource<List<ImportantDate>>? dates,
    Resource<List<Holiday>>? holidays,
    FormInput<String>? title,
    ImportantDateKind? kind,
    int? month,
    int? day,
    FormInput<String>? year,
    Resource<void>? saveAction,
  }) {
    return DatesState(
      view: view ?? this.view,
      dates: dates ?? this.dates,
      holidays: holidays ?? this.holidays,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      month: month ?? this.month,
      day: day ?? this.day,
      year: year ?? this.year,
      saveAction: saveAction ?? this.saveAction,
    );
  }

  @override
  List<Object?> get props => [view, dates, holidays, title, kind, month, day, year, saveAction];
}
