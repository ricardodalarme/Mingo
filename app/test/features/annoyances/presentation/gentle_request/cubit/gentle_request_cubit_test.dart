import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/annoyances/presentation/gentle_request/cubit/gentle_request_cubit.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAnnoyanceRepository() extends Mock implements AnnoyanceRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

void main() {
  late AnnoyanceRepository annoyances;
  late ProfileRepository profile;

  setUp(() {
    annoyances = _MockAnnoyanceRepository();
    profile = _MockProfileRepository();
    when(() => profile.getMySettings()).thenAnswer(
      (_) async => const AccountSettings(theme: AppThemeVariant.rose, partnerName: 'Ricardo'),
    );
    when(
      () => annoyances.sendGentleRequest(
        whenText: any(named: 'whenText'),
        feelText: any(named: 'feelText'),
        wishText: any(named: 'wishText'),
        annoyanceId: any(named: 'annoyanceId'),
      ),
    ).thenAnswer((_) async {});
  });

  GentleRequestCubit build() =>
      GentleRequestCubit(annoyanceRepository: annoyances, profileRepository: profile);

  void fill(GentleRequestCubit cubit) => cubit
    ..onWhenChanged('chego em casa')
    ..onFeelChanged('sozinha')
    ..onWishChanged('dividir a tarde');

  test('start reads the partner name for the preview', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.start();

    expect(cubit.state.partnerName, 'Ricardo');
  });

  test('the request is complete only with all three sentences', () {
    final cubit = build();
    addTearDown(cubit.close);

    expect(cubit.state.isComplete, isFalse);

    cubit.onWhenChanged('chego em casa');

    expect(cubit.state.isComplete, isFalse);

    fill(cubit);

    expect(cubit.state.isComplete, isTrue);
  });

  test('an incomplete request is not sent', () async {
    final cubit = build();
    addTearDown(cubit.close);
    cubit.onWhenChanged('chego em casa');

    await cubit.send();

    verifyNever(
      () => annoyances.sendGentleRequest(
        whenText: any(named: 'whenText'),
        feelText: any(named: 'feelText'),
        wishText: any(named: 'wishText'),
        annoyanceId: any(named: 'annoyanceId'),
      ),
    );
  });

  test('a complete request is sent with its source annoyance', () async {
    final cubit = build();
    addTearDown(cubit.close);
    fill(cubit);

    await cubit.send(annoyanceId: 'a1');

    verify(
      () => annoyances.sendGentleRequest(
        whenText: 'chego em casa',
        feelText: 'sozinha',
        wishText: 'dividir a tarde',
        annoyanceId: 'a1',
      ),
    ).called(1);
    expect(cubit.state.sendAction, isA<Success<void>>());
  });

  test('a failed send shows the error and lets the person try again', () async {
    when(
      () => annoyances.sendGentleRequest(
        whenText: any(named: 'whenText'),
        feelText: any(named: 'feelText'),
        wishText: any(named: 'wishText'),
        annoyanceId: any(named: 'annoyanceId'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: 'NOT_PAIRED'));
    final cubit = build();
    addTearDown(cubit.close);
    fill(cubit);

    await cubit.send();

    expect(cubit.state.sendAction, isA<Initial>());
    expect(cubit.state.whenText.value, 'chego em casa');
  });
}
