import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:app/features/widgets/presentation/gallery/cubit/widgets_gallery_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockWidgetsRepository() extends Mock implements WidgetsRepository;

void main() {
  late WidgetsRepository repository;
  late WidgetsGalleryCubit cubit;

  final overview = WidgetOverview.fake();

  setUpAll(() {
    registerFallbackValue(WidgetOverview.fake());
  });

  setUp(() {
    repository = _MockWidgetsRepository();
    cubit = WidgetsGalleryCubit(repository: repository);
  });

  tearDown(() => cubit.close());

  test('load emits Success with the repository overview', () async {
    when(() => repository.loadAndSync()).thenAnswer((_) async => overview);

    await cubit.load();

    expect(cubit.state.overview, Success(overview));
  });

  test('load emits Failure when the first read throws', () async {
    when(() => repository.loadAndSync()).thenThrow(Exception('network error'));

    await cubit.load();

    expect(cubit.state.overview, isA<Failure>());
  });

  test('savePrivacy writes both settings and replaces the overview', () async {
    final updated = WidgetOverview.fake().copyWith(
      preferences: WidgetOverview.fake().preferences.copyWith(
        showNames: false,
        allowPartnerNotes: false,
      ),
    );
    when(
      () => repository.savePrivacy(
        showNames: any(named: 'showNames'),
        allowPartnerNotes: any(named: 'allowPartnerNotes'),
        now: any(named: 'now'),
      ),
    ).thenAnswer((_) async => updated);

    await cubit.savePrivacy(showNames: false, allowPartnerNotes: false);

    expect(cubit.state.overview, Success(updated));
    expect(cubit.state.saveAction, isA<Initial>());
    verify(() => repository.savePrivacy(showNames: false, allowPartnerNotes: false)).called(1);
  });

  test('savePrivacy keeps the overview and emits Failure when the write fails', () async {
    when(() => repository.loadAndSync()).thenAnswer((_) async => overview);
    await cubit.load();
    when(
      () => repository.savePrivacy(
        showNames: any(named: 'showNames'),
        allowPartnerNotes: any(named: 'allowPartnerNotes'),
        now: any(named: 'now'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: 'WIDGET_PREFERENCES_SAVE_FAILED'));

    await cubit.savePrivacy(showNames: true, allowPartnerNotes: false);

    expect(cubit.state.overview, Success(overview));
    expect(cubit.state.saveAction, isA<Initial>());
  });

  test('a second tap while saving does not start another write', () async {
    when(
      () => repository.savePrivacy(
        showNames: any(named: 'showNames'),
        allowPartnerNotes: any(named: 'allowPartnerNotes'),
        now: any(named: 'now'),
      ),
    ).thenAnswer((_) async => overview);

    final first = cubit.savePrivacy(showNames: true, allowPartnerNotes: true);
    final second = cubit.savePrivacy(showNames: false, allowPartnerNotes: false);
    await Future.wait([first, second]);

    verify(
      () => repository.savePrivacy(
        showNames: any(named: 'showNames'),
        allowPartnerNotes: any(named: 'allowPartnerNotes'),
        now: any(named: 'now'),
      ),
    ).called(1);
  });
}
