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
        .thenAnswer((_) async => const SlipPage(items: [], hasNext: false));
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
}
