import 'package:app/features/privacy/data/models/consent.dart';
import 'package:app/features/privacy/data/repositories/privacy_repository.dart';
import 'package:app/features/privacy/presentation/consents/cubit/consents_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockPrivacyRepository() extends Mock implements PrivacyRepository;

void main() {
  late PrivacyRepository repository;

  setUpAll(() => registerFallbackValue(ConsentKind.analytics));

  setUp(() {
    repository = _MockPrivacyRepository();
    when(() => repository.setConsent(any(), granted: any(named: 'granted'))).thenAnswer((_) async {
      return;
    });
  });

  ConsentsCubit build() => ConsentsCubit(repository: repository);

  test('load shows the latest values', () async {
    when(() => repository.getConsents()).thenAnswer(
      (_) async => {
        ConsentKind.terms: true,
        ConsentKind.analytics: true,
        ConsentKind.marketing: false,
      },
    );
    final cubit = build();

    await cubit.load();

    final consents = (cubit.state.consents as Success<Map<ConsentKind, bool>>).value;
    expect(consents[ConsentKind.analytics], isTrue);
    expect(consents[ConsentKind.marketing], isFalse);
  });

  test('toggling an optional consent flips it and saves', () async {
    when(() => repository.getConsents()).thenAnswer((_) async => {ConsentKind.marketing: false});
    final cubit = build();
    await cubit.load();

    await cubit.toggle(ConsentKind.marketing);

    final consents = (cubit.state.consents as Success<Map<ConsentKind, bool>>).value;
    expect(consents[ConsentKind.marketing], isTrue);
    verify(() => repository.setConsent(ConsentKind.marketing, granted: true)).called(1);
  });

  test('a required consent never changes', () async {
    when(() => repository.getConsents()).thenAnswer((_) async => {ConsentKind.terms: true});
    final cubit = build();
    await cubit.load();

    await cubit.toggle(ConsentKind.terms);

    verifyNever(() => repository.setConsent(any(), granted: any(named: 'granted')));
  });

  test('a failed save reverts the switch and reports', () async {
    when(() => repository.getConsents()).thenAnswer((_) async => {ConsentKind.analytics: false});
    when(() => repository.setConsent(any(), granted: any(named: 'granted')))
        .thenAnswer((_) async => throw Exception('offline'));
    final cubit = build();
    await cubit.load();

    await cubit.toggle(ConsentKind.analytics);

    final consents = (cubit.state.consents as Success<Map<ConsentKind, bool>>).value;
    expect(consents[ConsentKind.analytics], isFalse);
    expect(cubit.state.saveAction, isA<Failure>());
  });
}
