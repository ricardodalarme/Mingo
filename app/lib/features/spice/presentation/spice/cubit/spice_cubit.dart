import 'dart:async';

import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'spice_state.dart';

class SpiceCubit({
  required final SpiceRepository _spiceRepository,
  required final PairingRepository _pairingRepository,
}) extends Cubit<SpiceState> {
  this : super(const SpiceState());

  StreamSubscription<SpiceStatus>? _live;

  /// Reads the mode and whether the person has a partner; what is on screen stays while it reloads.
  Future<void> load() async {
    if (state.status is! Success) emit(state.copyWith(status: const Loading()));
    try {
      final (status, partner) = await (
        _spiceRepository.getStatus(),
        _pairingRepository.getPartner(),
      ).wait;
      emit(state.copyWith(status: Success(status), hasPartner: partner != null));
      _watch();
    } catch (exception) {
      if (state.status is Success) return;
      emit(state.copyWith(status: Failure.fromObject(exception)));
    }
  }

  void onAdultChanged({required bool isAdult}) =>
      emit(state.copyWith(isAdult: isAdult, showAdultError: false));

  /// Switches the mode on for this person once they said they are an adult.
  Future<void> turnOn() async {
    if (state.changeAction.isLoading) return;
    if (!state.isAdult) {
      emit(state.copyWith(showAdultError: true));

      return;
    }

    await _change(_spiceRepository.turnOn);
  }

  Future<void> turnOff() async {
    if (state.changeAction.isLoading) return;

    await _change(_spiceRepository.turnOff);
  }

  Future<void> _change(Future<void> Function() action) async {
    emit(state.copyWith(changeAction: const Loading()));
    try {
      await action();
      emit(state.copyWith(changeAction: const Success(null)));
      await load();
    } catch (exception) {
      emit(state.copyWith(changeAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(changeAction: const Initial()));
  }

  /// Follows the mode after the first read, so the partner switching it on or off shows up while
  /// the page is open.
  void _watch() {
    _live ??= _spiceRepository.watchStatus().listen((status) {
      final current = state.status;
      if (current is! Success<SpiceStatus> || current.value == status) return;
      unawaited(load());
    });
  }

  @override
  Future<void> close() async {
    await _live?.cancel();

    return super.close();
  }
}
