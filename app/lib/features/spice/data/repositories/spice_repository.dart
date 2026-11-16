import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/spice/data/data_sources/remote/spice_data_source.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

/// What the spice page can show.
enum SpiceStage() {
  /// The person has not switched the mode on, or safe mode hides it.
  off,

  /// The person switched it on but the server returns no cards yet.
  waiting,

  /// Both switched it on and cards are available.
  ready,

  /// The cards need Plus, and the person does not have it.
  plusLocked,
}

/// The state of the mode and its cards.
final class const SpiceView({required final SpiceStage stage, final List<String> cards = const []})
    with Equatable {
  @override
  List<Object?> get props => [stage, cards];
}

class SpiceRepository({
  required final SpiceDataSource _dataSource,
  required final ProfileRepository _profileRepository,
  required final PlusRepository _plusRepository,
  required final AuthenticationRepository _authenticationRepository,
}) {
  final Logger _logger = Logger('SpiceRepository');

  Future<SpiceView> getView() async {
    try {
      if (!(await _plusRepository.getPlus()).hasPlus) {
        return const SpiceView(stage: SpiceStage.plusLocked);
      }

      final userId = _authenticationRepository.currentUserId;
      if (userId == null) return const SpiceView(stage: SpiceStage.off);

      final enabled = await _dataSource.getEnabled(userId);
      if (!enabled) return const SpiceView(stage: SpiceStage.off);

      final settings = await _profileRepository.getMySettings();
      final cards = await _dataSource.getCards(settings.locale);

      return SpiceView(stage: cards.isEmpty ? SpiceStage.waiting : SpiceStage.ready, cards: cards);
    } catch (e, stack) {
      _logger.error('Failed to read the spice mode', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Switches the mode for this person only; nothing is sent to the partner.
  Future<void> setEnabled({required bool enabled}) async {
    try {
      final userId = _authenticationRepository.currentUserId;
      if (userId == null) throw const LocalizedException(l10nKey: 'UNAUTHENTICATED');

      final affected = await _dataSource.setEnabled(userId: userId, enabled: enabled);
      if (affected != 1) throw const LocalizedException(l10nKey: 'UPDATE_FAILED');
    } catch (e, stack) {
      _logger.error('Failed to change the spice mode', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
