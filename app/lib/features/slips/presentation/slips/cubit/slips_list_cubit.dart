import 'dart:async';

import 'package:app/features/_shared/data/models/page_info.dart';
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

  StreamSubscription<PageInfo<SlipEntry>>? _slips;
  int _count = slipPageSize;

  /// Starts following the list; it updates itself when a slip is saved, edited or removed.
  void start() => unawaited(load());

  /// Follows the first slips of the scope again; the list on screen stays until new ones arrive.
  Future<void> load() {
    if (state.scope == SlipsScope.jar) return Future.value();
    if (state.slips is! Success) emit(state.copyWith(slips: const Loading()));

    return _watch();
  }

  Future<void> changeScope(SlipsScope scope) async {
    if (scope == state.scope) return;

    _count = slipPageSize;
    emit(SlipsListState(scope: scope));
    await load();
  }

  /// Asks for the next page; ignored while one is loading or when there is none.
  Future<void> loadMore() async {
    if (state.slips is! Success<List<SlipEntry>> || !state.hasNext || state.isLoadingMore) return;

    _count += slipPageSize;
    emit(state.copyWith(isLoadingMore: true));
    await _watch();
  }

  /// Watches the first [_count] slips, so one list holds every loaded page and a change anywhere
  /// in it keeps the pages consistent. Completes with the first result or error.
  Future<void> _watch() {
    unawaited(_slips?.cancel());
    final first = Completer<void>();
    _slips = _slipRepository
        .watchSlips(count: _count, filter: _filter(state.scope, clock.now()))
        .listen(
          (page) {
            emit(
              SlipsListState(
                slips: Success(page.items),
                scope: state.scope,
                hasNext: page.hasNext,
                offset: page.offset,
              ),
            );
            if (!first.isCompleted) first.complete();
          },
          onError: (Object exception) {
            if (state.slips is Success) {
              emit(state.copyWith(isLoadingMore: false));
            } else {
              emit(state.copyWith(slips: Failure.fromObject(exception)));
            }
            if (!first.isCompleted) first.complete();
          },
        );

    return first.future;
  }

  @override
  Future<void> close() async {
    await _slips?.cancel();

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
      SlipsScope.jar => const SlipFilter(),
    };
  }
}
