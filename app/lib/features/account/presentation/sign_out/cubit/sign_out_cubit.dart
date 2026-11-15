import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/today/data/repositories/today_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preferences_service/preferences_service.dart';
import 'package:secure_storage_service/secure_storage_service.dart';

part 'sign_out_state.dart';

/// Signs out, optionally erasing everything kept on this device.
class SignOutCubit({
  required final AuthenticationRepository _authenticationRepository,
  required final AppCubit _appCubit,
  required final SlipRepository _slipRepository,
  required final RemindersRepository _remindersRepository,
  required final PreferencesService _preferencesService,
  required final SecureStorageService _secureStorageService,
  required final TodayRepository _todayRepository,
  required final MoodRepository _moodRepository,
}) extends Cubit<SignOutState> {
  this : super(const SignOutState());

  void load() => emit(state.copyWith(pendingSlips: _slipRepository.pendingCount));

  Future<void> signOut({required bool removeLocalData}) async {
    emit(state.copyWith(action: const Loading()));
    _appCubit.markExplicitSignOut();
    try {
      await _authenticationRepository.logOut();
      // The pairing notice and the cached mood belong to the account that just left.
      await _todayRepository.clearCache();
      await _moodRepository.clearCache();
      if (removeLocalData) {
        await _remindersRepository.cancelAll();
        await _preferencesService.clear();
        await _secureStorageService.clear();
      }
      if (!isClosed) emit(state.copyWith(action: const Success(null)));
    } catch (exception) {
      _appCubit.cancelExplicitSignOut();
      if (!isClosed) emit(state.copyWith(action: Failure.fromObject(exception)));
    }
  }
}
