import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:app/features/widgets/presentation/own_medium/cubit/own_medium_widgets_cubit.dart';
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

  blocTest<OwnMediumWidgetsCubit, OwnMediumWidgetsState>(
    'emits Loading then Success on load',
    build: () {
      when(() => repository.loadAndSync()).thenAnswer((_) async => overview);
      return OwnMediumWidgetsCubit(repository: repository);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const OwnMediumWidgetsState(overview: Loading()),
      OwnMediumWidgetsState(overview: Success(overview)),
    ],
  );
}
