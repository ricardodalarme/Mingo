import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/data/repositories/home_widgets_repository.dart';
import 'package:app/features/home_widgets/presentation/gallery/cubit/home_widgets_gallery_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockHomeWidgetsRepository() extends Mock implements HomeWidgetsRepository;

void main() {
  late HomeWidgetsRepository repository;
  late HomeWidgetsGalleryCubit cubit;

  final payload = HomeWidgetPayload.fake();

  setUp(() {
    repository = _MockHomeWidgetsRepository();
    cubit = HomeWidgetsGalleryCubit(repository: repository);
  });

  tearDown(() => cubit.close());

  test('starts loading', () {
    expect(cubit.state.payload, const Loading());
  });

  test('load emits Success with the repository payload', () async {
    when(() => repository.loadAndSync()).thenAnswer((_) async => payload);

    await cubit.load();

    expect(cubit.state.payload, Success(payload));
  });

  test('load emits Failure when the first read throws', () async {
    when(() => repository.loadAndSync()).thenThrow(Exception('network error'));

    await cubit.load();

    expect(cubit.state.payload, isA<Failure>());
  });

  test('a failed reload keeps what is on screen', () async {
    when(() => repository.loadAndSync()).thenAnswer((_) async => payload);
    await cubit.load();
    when(() => repository.loadAndSync()).thenThrow(Exception('network error'));

    await cubit.load();

    expect(cubit.state.payload, Success(payload));
  });
}
