import 'dart:async';

import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_filter.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'slips_list_state.dart';

class SlipsListCubit({required final SlipRepository _slipRepository})
    extends Cubit<SlipsListState> {
  this : super(const SlipsListState());

  StreamSubscription<void>? _changes;

  /// Loads the list and reads it again whenever a slip is saved, undone or sent.
  void start() {
    _changes = _slipRepository.onChanged.listen((_) => load());
    load();
  }

  /// Reads the first page again; the list on screen stays until the new one arrives.
  Future<void> load() async {
    if (state.slips is! Success) emit(state.copyWith(slips: const Loading()));
    try {
      final page = await _slipRepository.getSlips(filter: _filter(state.scope, clock.now()));
      emit(
        SlipsListState(
          slips: Success(page.items),
          scope: state.scope,
          hasNext: page.hasNext,
          offset: page.offset,
        ),
      );
    } catch (exception) {
      if (state.slips is Success) return;
      emit(state.copyWith(slips: Failure.fromObject(exception)));
    }
  }

  Future<void> changeScope(SlipsScope scope) async {
    if (scope == state.scope) return;

    emit(SlipsListState(scope: scope));
    await load();
  }

  /// Appends the next page; ignored while one is loading or when there is none.
  Future<void> loadMore() async {
    final current = state.slips;
    if (current is! Success<List<SlipEntry>> || !state.hasNext || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));
    try {
      final page = await _slipRepository.getSlips(
        offset: state.offset,
        filter: _filter(state.scope, clock.now()),
      );
      final knownIds = current.value.map((slip) => slip.id).toSet();
      emit(
        SlipsListState(
          slips: Success([
            ...current.value,
            ...page.items.where((slip) => !knownIds.contains(slip.id)),
          ]),
          scope: state.scope,
          hasNext: page.hasNext,
          offset: page.offset,
        ),
      );
    } on Object {
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  @override
  Future<void> close() async {
    await _changes?.cancel();
    return super.close();
  }

  /// The slips [scope] asks for; the week starts on Monday at 00:00.
  static SlipFilter _filter(SlipsScope scope, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);

    return switch (scope) {
      SlipsScope.week => SlipFilter(
        since: today.subtract(Duration(days: today.weekday - DateTime.monday)),
      ),
      SlipsScope.all => const SlipFilter(),
      SlipsScope.private => const SlipFilter(inCard: false),
    };
  }
}
