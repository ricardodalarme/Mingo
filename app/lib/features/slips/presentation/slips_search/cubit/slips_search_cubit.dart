import 'dart:async';

import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_filter.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'slips_search_state.dart';

const Duration _typingPause = Duration(milliseconds: 300);

class SlipsSearchCubit({required final SlipRepository _slipRepository})
    extends Cubit<SlipsSearchState> {
  this : super(const SlipsSearchState());

  Timer? _timer;

  /// Shows the newest slips before anything is typed.
  Future<void> start() => _search();

  void onQueryChanged(String query) {
    emit(state.copyWith(query: query));
    _timer?.cancel();
    _timer = Timer(_typingPause, _search);
  }

  /// Switches [filter] on or off. A slip is either private or in a card, so those two exclude each other.
  Future<void> toggle(SlipsSearchFilter filter) {
    final filters = {...state.filters};
    if (!filters.remove(filter)) {
      filters.add(filter);
      if (filter == SlipsSearchFilter.private) filters.remove(SlipsSearchFilter.inCard);
      if (filter == SlipsSearchFilter.inCard) filters.remove(SlipsSearchFilter.private);
    }
    emit(state.copyWith(filters: filters));

    return _search();
  }

  Future<void> _search() async {
    final now = clock.now();
    final filters = state.filters;
    final filter = SlipFilter(
      since: filters.contains(SlipsSearchFilter.thisMonth) ? DateTime(now.year, now.month) : null,
      inCard: filters.contains(SlipsSearchFilter.inCard)
          ? true
          : filters.contains(SlipsSearchFilter.private)
          ? false
          : null,
      onlyInvisible: filters.contains(SlipsSearchFilter.invisible),
      text: state.query,
    );
    try {
      final page = await _slipRepository.getSlips(filter: filter);
      if (!isClosed) emit(state.copyWith(results: Success(page.items)));
    } catch (exception, stack) {
      addError(exception, stack);
      if (!isClosed) emit(state.copyWith(results: Failure.fromObject(exception)));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
