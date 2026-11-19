import 'dart:async';

import 'package:app/features/_shared/data/models/page_info.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_filter.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/slips_search/cubit/slips_search_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  late SlipRepository repository;

  setUpAll(() => registerFallbackValue(const SlipFilter()));

  setUp(() {
    repository = _MockSlipRepository();
    when(() => repository.getSlips(filter: any(named: 'filter')))
        .thenAnswer((_) async => const PageInfo<SlipEntry>(items: [], hasNext: false));
  });

  SlipsSearchCubit build() => SlipsSearchCubit(slipRepository: repository);

  test('start shows the newest slips', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.start();

    expect(cubit.state.results, isA<Success<List<SlipEntry>>>());
    verify(() => repository.getSlips(filter: const SlipFilter())).called(1);
  });

  test('a filter narrows the search', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.toggle(SlipsSearchFilter.invisible);

    verify(() => repository.getSlips(filter: const SlipFilter(onlyInvisible: true))).called(1);
  });

  test('private and in a card exclude each other', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.toggle(SlipsSearchFilter.private);
    await cubit.toggle(SlipsSearchFilter.inCard);

    expect(cubit.state.filters, {SlipsSearchFilter.inCard});
    verify(() => repository.getSlips(filter: const SlipFilter(inCard: true))).called(1);
  });

  test('switching a filter off widens the search again', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.toggle(SlipsSearchFilter.private);
    await cubit.toggle(SlipsSearchFilter.private);

    expect(cubit.state.filters, isEmpty);
  });

  test('typing waits for a pause, then searches the text', () async {
    final cubit = build();
    addTearDown(cubit.close);

    cubit.onQueryChanged('café');
    await Future<void>.delayed(const Duration(milliseconds: 400));

    verify(() => repository.getSlips(filter: const SlipFilter(text: 'café'))).called(1);
  });

  test('a failing search shows a failure', () async {
    when(() => repository.getSlips(filter: any(named: 'filter'))).thenThrow(Exception());
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.start();

    expect(cubit.state.results, isA<Failure>());
  });

  group('loadMore', () {
    SlipEntry slip(String id) => SlipEntry(id: id, body: id, createdAt: DateTime(2026, 3, 10));

    test('appends the next page after the loaded ones', () async {
      when(
        () => repository.getSlips(filter: any(named: 'filter')),
      ).thenAnswer((_) async => PageInfo<SlipEntry>(items: [slip('a'), slip('b')], hasNext: true));
      when(() => repository.getSlips(offset: 2, filter: any(named: 'filter')))
          .thenAnswer((_) async => PageInfo<SlipEntry>(items: [slip('c')], hasNext: false));
      final cubit = build();
      addTearDown(cubit.close);
      await cubit.start();

      await cubit.loadMore();

      final results = cubit.state.results as Success<List<SlipEntry>>;
      expect(results.value.map((slip) => slip.id), ['a', 'b', 'c']);
      expect(cubit.state.hasNext, isFalse);
      expect(cubit.state.isLoadingMore, isFalse);
    });

    test('does nothing when there is no next page', () async {
      final cubit = build();
      addTearDown(cubit.close);
      await cubit.start();

      await cubit.loadMore();

      verify(() => repository.getSlips(filter: any(named: 'filter'))).called(1);
    });

    test('keeps what is loaded when the next page fails', () async {
      when(() => repository.getSlips(filter: any(named: 'filter')))
          .thenAnswer((_) async => PageInfo<SlipEntry>(items: [slip('a')], hasNext: true));
      when(() => repository.getSlips(offset: 1, filter: any(named: 'filter')))
          .thenThrow(Exception());
      final cubit = build();
      addTearDown(cubit.close);
      await cubit.start();

      await runZonedGuarded(cubit.loadMore, (_, _) {});

      expect(cubit.state.results, isA<Success<List<SlipEntry>>>());
      expect(cubit.state.isLoadingMore, isFalse);
    });
  });
}
