import 'dart:async';

import 'package:app/features/agreements/data/models/agreement.dart';
import 'package:app/features/agreements/data/repositories/agreements_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'agreements_state.dart';

class AgreementsCubit({required final AgreementsRepository _repository})
    extends Cubit<AgreementsState> {
  this : super(const AgreementsState());

  final Uuid _uuid = const Uuid();
  StreamSubscription<List<Agreement>>? _live;

  Future<void> load() async {
    if (state.agreements is! Success) emit(state.copyWith(agreements: const Loading()));
    try {
      final (coupleId, agreements) = await (
        _repository.getCoupleId(),
        _repository.getAgreements(),
      ).wait;
      emit(state.copyWith(agreements: Success(agreements), coupleId: coupleId));
      _watch();
    } catch (exception) {
      if (state.agreements is Success) return;
      emit(state.copyWith(agreements: Failure.fromObject(exception)));
    }
  }

  /// Proposes [body]; with a partner it waits for their confirmation, alone it stays a private note.
  Future<void> add(String body) async {
    if (state.changeAction.isLoading) return;

    emit(state.copyWith(changeAction: const Loading()));
    try {
      final saved = await _repository.addAgreement(id: _uuid.v4(), body: body);
      emit(
        state.copyWith(
          agreements: Success([saved, ...state.current]),
          changeAction: const Success(null),
        ),
      );
    } catch (exception) {
      emit(state.copyWith(changeAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(changeAction: const Initial()));
  }

  Future<void> confirm(Agreement agreement) async {
    if (state.changeAction.isLoading) return;

    emit(state.copyWith(changeAction: const Loading()));
    try {
      final saved = await _repository.confirmAgreement(agreement.id);
      emit(
        state.copyWith(
          agreements: Success([
            for (final item in state.current)
              if (item.id == saved.id) saved else item,
          ]),
          changeAction: const Success(null),
        ),
      );
    } catch (exception) {
      emit(state.copyWith(changeAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(changeAction: const Initial()));
  }

  Future<void> archive(Agreement agreement) async {
    if (state.changeAction.isLoading) return;

    emit(state.copyWith(changeAction: const Loading()));
    try {
      await _repository.archiveAgreement(agreement.id);
      emit(
        state.copyWith(
          agreements: Success([
            for (final item in state.current)
              if (item.id != agreement.id) item,
          ]),
          changeAction: const Success(null),
        ),
      );
    } catch (exception) {
      emit(state.copyWith(changeAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(changeAction: const Initial()));
  }

  /// Follows the agreements after the first read, so a proposal or confirmation by the partner
  /// shows up while the page is open.
  void _watch() {
    _live ??= _repository.watchAgreements().listen((agreements) {
      if (state.changeAction.isLoading) return;
      emit(state.copyWith(agreements: Success(agreements)));
    });
  }

  @override
  Future<void> close() async {
    await _live?.cancel();

    return super.close();
  }
}
