import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:app/features/spice/presentation/settings/cubit/spice_settings_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSpiceRepository() extends Mock implements SpiceRepository;

void main() {
  late SpiceRepository spice;
  const settings = SpiceSettings(maxLevel: SpiceLevel.soft, notifications: false);

  setUpAll(() => registerFallbackValue(settings));

  setUp(() {
    spice = _MockSpiceRepository();
    when(spice.getSettings).thenAnswer((_) async => settings);
    when(() => spice.setSettings(any())).thenAnswer((_) async {});
  });

  test('choosing a level saves it and keeps the notifications', () async {
    final cubit = SpiceSettingsCubit(spiceRepository: spice);
    await cubit.load();

    await cubit.onLevelChosen(SpiceLevel.hot);

    verify(
      () => spice.setSettings(const SpiceSettings(maxLevel: SpiceLevel.hot, notifications: false)),
    ).called(1);
    expect((cubit.state.settings as Success<SpiceSettings>).value.maxLevel, SpiceLevel.hot);
  });

  test('a refused save puts the previous settings back', () async {
    when(() => spice.setSettings(any())).thenThrow(Exception('offline'));
    final cubit = SpiceSettingsCubit(spiceRepository: spice);
    await cubit.load();

    await cubit.onNotificationsChanged(isOn: true);

    expect(cubit.state.settings, const Success(settings));
  });
}
