import 'package:app/features/guides/data/models/guide.dart';
import 'package:app/features/guides/data/repositories/guides_repository.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'guides_state.dart';

class GuidesCubit({
  required final GuidesRepository _repository,
  required final PlusRepository _plusRepository,
}) extends Cubit<GuidesState> {
  this : super(const GuidesState());

  /// Reads the local catalogue in the current app language and whether Plus is active.
  Future<void> load() async {
    emit(state.copyWith(guides: const Loading()));
    final plan = _readHasPlus();
    final guidesRead = _repository.getGuides(
      languageCode: LocaleSettings.currentLocale.languageCode,
    );
    try {
      final guides = await guidesRead;
      final hasPlus = await plan;
      if (isClosed) return;
      emit(state.copyWith(guides: Success(guides), hasPlus: hasPlus));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(guides: Failure.fromObject(exception)));
    }
  }

  /// Without a known plan the Plus guides stay locked and the free ones stay open.
  Future<bool> _readHasPlus() async {
    try {
      return (await _plusRepository.getPlus()).hasPlus;
    } on Object {
      return false;
    }
  }
}
