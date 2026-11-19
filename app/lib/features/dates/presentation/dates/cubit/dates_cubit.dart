import 'package:app/features/dates/data/models/dates_models.dart';
import 'package:app/features/dates/data/models/important_date_kind.dart';
import 'package:app/features/dates/data/repositories/dates_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:uuid/uuid.dart';

part 'dates_state.dart';

final RegExp _yearPattern = RegExp(r'^\s*$|^\s*(?:19\d{2}|20\d{2}|21\d{2}|2200)\s*$');

/// The two views of the dates screen.
enum DatesView() {
  dates,
  holidays,
}

class DatesCubit({
  required final DatesRepository _datesRepository,
  required final ProfileRepository _profileRepository,
}) extends Cubit<DatesState> {
  this : super(const DatesState());

  final Uuid _uuid = const Uuid();

  void onViewChanged(DatesView view) => emit(state.copyWith(view: view));

  /// Reads the dates; holidays are read once.
  Future<void> load() async {
    if (state.dates is! Success) emit(state.copyWith(dates: const Loading()));
    await (_loadDates(), _loadHolidays()).wait;
  }

  Future<void> _loadDates() async {
    try {
      final dates = await _datesRepository.getDates();
      emit(state.copyWith(dates: Success(dates)));
    } catch (exception, stack) {
      addError(exception, stack);
      if (state.dates is! Success) emit(state.copyWith(dates: Failure.fromObject(exception)));
    }
  }

  void onTitleChanged(String title) => emit(state.copyWith(title: FormInput(title)));

  void onKindChosen(ImportantDateKind kind) => emit(state.copyWith(kind: kind));

  void onMonthChosen(int month) => emit(state.copyWith(month: month));

  void onDayChosen(int day) => emit(state.copyWith(day: day));

  void onYearChanged(String year) => emit(state.copyWith(year: FormInput(year)));

  /// Saves the date being typed; an unknown year still repeats every year.
  ///
  /// A reunion is a single meeting, so it never repeats yearly.
  Future<void> saveDate() async {
    if (state.saveAction.isLoading || !_validate()) return;

    emit(state.copyWith(saveAction: const Loading()));
    try {
      await _datesRepository.addDate(
        id: _uuid.v4(),
        title: state.title.value,
        kind: state.kind,
        month: state.month!,
        day: state.day!,
        year: state.yearValue,
        isYearly: state.kind != ImportantDateKind.reunion,
      );
      emit(
        state.copyWith(
          title: const FormInput(''),
          year: const FormInput(''),
          saveAction: const Success(null),
        ),
      );
      await load();
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(saveAction: const Initial()));
  }

  bool _validate() {
    final validatedTitle = state.title.validate(
      CompositeValidator<String>([NonEmptyValidator(), MaxLengthValidator(dateTitleMaxLength)]),
    );
    final validatedYear = state.year.validate(PatternValidator(_yearPattern));

    emit(state.copyWith(title: validatedTitle, year: validatedYear));

    final month = state.month;
    final day = state.day;

    return validatedTitle.isValid &&
        validatedYear.isValid &&
        month != null &&
        day != null &&
        isValidMonthDay(month, day);
  }

  Future<void> addHoliday(Holiday holiday) => _change(
    () => _datesRepository.addDate(
      id: _uuid.v4(),
      title: holiday.title,
      kind: ImportantDateKind.holiday,
      month: holiday.month,
      day: holiday.day,
      holidayKey: holiday.slug,
    ),
  );

  Future<void> deleteDate(ImportantDate date) =>
      _change(() => _datesRepository.deleteDate(date.id));

  Future<void> _loadHolidays() async {
    if (state.holidays is Success) return;

    try {
      final settings = await _profileRepository.getMySettings();
      final holidays = await _datesRepository.getHolidays(settings.locale);
      emit(state.copyWith(holidays: Success(holidays)));
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(holidays: Failure.fromObject(exception)));
    }
  }

  Future<void> _change(Future<void> Function() action) async {
    try {
      await action();
      await load();
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
      emit(state.copyWith(saveAction: const Initial()));
    }
  }
}
