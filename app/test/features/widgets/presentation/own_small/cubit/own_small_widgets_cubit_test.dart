import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:app/features/widgets/presentation/own_small/cubit/own_small_widgets_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockWidgetsRepository() extends Mock implements WidgetsRepository;

void main() {
  late WidgetsRepository repository;

  setUp(() {
    repository = _MockWidgetsRepository();
  });

  final overview = WidgetOverview.fake();

  blocTest<OwnSmallWidgetsCubit, OwnSmallWidgetsState>(
    'emits Loading then Success on load',
    build: () {
      when(() => repository.loadAndSync()).thenAnswer((_) async => overview);
      return OwnSmallWidgetsCubit(repository: repository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const OwnSmallWidgetsState(overview: Loading()),
      OwnSmallWidgetsState(overview: Success(overview)),
    ],
  );

  blocTest<OwnSmallWidgetsCubit, OwnSmallWidgetsState>(
    'keeps the loaded overview when a refresh fails',
    build: () {
      var calls = 0;
      when(() => repository.loadAndSync()).thenAnswer((_) async {
        calls += 1;
        if (calls == 1) return overview;
        throw Exception('offline');
      });
      return OwnSmallWidgetsCubit(repository: repository);
    },
    act: (cubit) async {
      await cubit.load();
      await cubit.load();
    },
    expect: () => [
      const OwnSmallWidgetsState(overview: Loading()),
      OwnSmallWidgetsState(overview: Success(overview)),
    ],
  );
}
