import 'dart:async';

import 'package:app/features/_shared/data/models/page_info.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_filter.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/slips/cubit/slips_list_cubit.dart';
import 'package:app/features/slips/presentation/slips/widgets/slips_groups.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

SlipEntry _slip(String id, DateTime at) => SlipEntry(id: id, body: id, createdAt: at);

void main() {
  setUpAll(() => registerFallbackValue(const SlipFilter()));

  late SlipRepository repository;
  late StreamController<PageInfo<SlipEntry>> pages;

  setUp(() {
    repository = _MockSlipRepository();
    pages = StreamController<PageInfo<SlipEntry>>.broadcast();
    addTearDown(pages.close);
  });

  SlipsListCubit build() => SlipsListCubit(slipRepository: repository);

  /// Answers each watch with [page] straight away.
  void stubPage(PageInfo<SlipEntry> page) => when(
    () => repository.watchSlips(
      count: any(named: 'count'),
      filter: any(named: 'filter'),
    ),
  ).thenAnswer((_) => Stream.value(page));

  group('groupByWeek', () {
    test('puts slips from the same Monday-to-Sunday week together, keeping the order', () {
      final groups = groupByWeek([
        _slip('a', DateTime(2026, 11, 9, 20)),
        _slip('b', DateTime(2026, 11, 8, 9)),
        _slip('c', DateTime(2026, 11, 2, 9)),
      ]);

      expect(groups.keys, [DateTime(2026, 11, 9), DateTime(2026, 11, 2)]);
      expect(groups[DateTime(2026, 11, 9)]!.map((slip) => slip.id), ['a']);
      expect(groups[DateTime(2026, 11, 2)]!.map((slip) => slip.id), ['b', 'c']);
    });
  });

  group('SlipsListCubit', () {
    test('load shows the first page', () async {
      stubPage(
        PageInfo<SlipEntry>(items: [_slip('a', DateTime(2026, 11, 9))], hasNext: true, offset: 1),
      );
      final cubit = build();
      addTearDown(cubit.close);

      await cubit.load();

      expect(cubit.state.slips, isA<Success<List<SlipEntry>>>());
      expect(cubit.state.hasNext, isTrue);
      expect(cubit.state.offset, 1);
    });

    test('an empty page is a success with no items, never an error', () async {
      stubPage(const PageInfo<SlipEntry>(items: [], hasNext: false));
      final cubit = build();
      addTearDown(cubit.close);

      await cubit.load();

      expect((cubit.state.slips as Success<List<SlipEntry>>).value, isEmpty);
    });

    test('loadMore watches one page more and keeps every loaded slip', () async {
      stubPage(
        PageInfo<SlipEntry>(items: [_slip('a', DateTime(2026, 11, 9))], hasNext: true, offset: 1),
      );
      final cubit = build();
      addTearDown(cubit.close);
      await cubit.load();

      stubPage(
        PageInfo<SlipEntry>(
          items: [_slip('a', DateTime(2026, 11, 9)), _slip('b', DateTime(2026, 11, 2))],
          hasNext: false,
          offset: 2,
        ),
      );
      await cubit.loadMore();

      final items = (cubit.state.slips as Success<List<SlipEntry>>).value;
      expect(items.map((slip) => slip.id), ['a', 'b']);
      expect(cubit.state.hasNext, isFalse);
      expect(cubit.state.isLoadingMore, isFalse);
      verify(
        () => repository.watchSlips(
          count: slipPageSize * 2,
          filter: any(named: 'filter'),
        ),
      ).called(1);
    });

    test('loadMore does nothing when there is no next page', () async {
      stubPage(const PageInfo<SlipEntry>(items: [], hasNext: false));
      final cubit = build();
      addTearDown(cubit.close);
      await cubit.load();
      await cubit.loadMore();

      verify(
        () => repository.watchSlips(
          count: any(named: 'count'),
          filter: any(named: 'filter'),
        ),
      ).called(1);
    });

    test('changing the scope watches the list again from the start', () async {
      stubPage(const PageInfo<SlipEntry>(items: [], hasNext: false));
      final cubit = build();
      addTearDown(cubit.close);
      await cubit.load();

      await cubit.changeScope(SlipsScope.all);

      expect(cubit.state.scope, SlipsScope.all);
      verify(() => repository.watchSlips(count: slipPageSize, filter: const SlipFilter()))
          .called(1);
    });

    test('the private scope watches the slips kept out of the weekly card', () async {
      stubPage(const PageInfo<SlipEntry>(items: [], hasNext: false));
      final cubit = build();
      addTearDown(cubit.close);
      await cubit.load();

      await cubit.changeScope(SlipsScope.private);

      verify(
        () => repository.watchSlips(count: slipPageSize, filter: const SlipFilter(inCard: false)),
      ).called(1);
    });

    test('a failed first load shows a failure', () async {
      when(
        () => repository.watchSlips(
          count: any(named: 'count'),
          filter: any(named: 'filter'),
        ),
      ).thenAnswer((_) => Stream.error(Exception()));
      final cubit = build();
      addTearDown(cubit.close);

      await cubit.load();

      expect(cubit.state.slips, isA<Failure>());
    });

    test('a failed update keeps the list on screen', () async {
      when(
        () => repository.watchSlips(
          count: any(named: 'count'),
          filter: any(named: 'filter'),
        ),
      ).thenAnswer((_) => pages.stream);
      final cubit = build()..start();
      addTearDown(cubit.close);
      pages.add(
        PageInfo<SlipEntry>(items: [_slip('a', DateTime(2026, 11, 9))], hasNext: false, offset: 1),
      );
      await pumpEventQueue();

      pages.addError(Exception());
      await pumpEventQueue();

      expect(cubit.state.slips, isA<Success<List<SlipEntry>>>());
    });

    test('a slip saved from another screen shows up without reading again', () async {
      when(
        () => repository.watchSlips(
          count: any(named: 'count'),
          filter: any(named: 'filter'),
        ),
      ).thenAnswer((_) => pages.stream);
      final cubit = build()..start();
      addTearDown(cubit.close);
      pages.add(const PageInfo<SlipEntry>(items: [], hasNext: false));
      await pumpEventQueue();

      pages.add(
        PageInfo<SlipEntry>(items: [_slip('a', DateTime(2026, 11, 9))], hasNext: false, offset: 1),
      );
      await pumpEventQueue();

      final items = (cubit.state.slips as Success<List<SlipEntry>>).value;
      expect(items.map((slip) => slip.id), ['a']);
      verify(
        () => repository.watchSlips(
          count: any(named: 'count'),
          filter: any(named: 'filter'),
        ),
      ).called(1);
    });

    test('stops watching when it closes', () async {
      when(
        () => repository.watchSlips(
          count: any(named: 'count'),
          filter: any(named: 'filter'),
        ),
      ).thenAnswer((_) => pages.stream);
      final cubit = build()..start();

      await cubit.close();

      expect(pages.hasListener, isFalse);
    });
  });
}
