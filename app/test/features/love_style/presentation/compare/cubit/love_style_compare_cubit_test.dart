import 'package:app/features/love_style/data/models/love_style_entry.dart';
import 'package:app/features/love_style/data/repositories/love_style_repository.dart';
import 'package:app/features/love_style/presentation/compare/cubit/love_style_compare_cubit.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoveStyleRepository() extends Mock implements LoveStyleRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

void main() {
  late LoveStyleRepository repository;
  late PairingRepository pairingRepository;

  const ranked = ['touch', 'time', 'words', 'acts', 'gifts'];

  setUp(() {
    repository = _MockLoveStyleRepository();
    pairingRepository = _MockPairingRepository();
    when(() => pairingRepository.getPartner()).thenAnswer(
      (_) async => const Profile(id: 'p1', avatarKind: AvatarKind.initials, displayName: 'Marina'),
    );
  });

  LoveStyleCompareCubit build() =>
      LoveStyleCompareCubit(repository: repository, pairingRepository: pairingRepository);

  test('both shared results make a comparison with the partner name', () async {
    when(() => repository.getOverview()).thenAnswer(
      (_) async => LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: ranked, sharedAt: DateTime.utc(2026, 3)),
        partner: const LoveStyleEntry(id: 'q2', ranked: ranked),
      ),
    );

    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    final comparison = switch (cubit.state.comparison) {
      Success(:final value) => value,
      _ => null,
    };
    expect(comparison?.commonPattern, 'touch');
    expect(cubit.state.partnerName, 'Marina');
  });

  test('a result the person has not shown leaves the comparison empty', () async {
    when(() => repository.getOverview()).thenAnswer(
      (_) async => const LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: ranked),
        partner: LoveStyleEntry(id: 'q2', ranked: ranked),
      ),
    );

    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    expect(cubit.state.comparison, const Success<LoveStyleComparison?>(null));
  });

  test('a failed read is a failure the page can retry', () async {
    when(() => repository.getOverview()).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));

    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    expect(cubit.state.comparison, isA<Failure>());
  });
}
