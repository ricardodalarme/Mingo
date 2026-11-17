import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockHistoryRepository() extends Mock implements HistoryRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

void main() {
  late HistoryRepository history;
  late PairingRepository pairing;

  setUp(() {
    history = _MockHistoryRepository();
    pairing = _MockPairingRepository();
  });

  CoupleCubit build() => CoupleCubit(historyRepository: history, pairingRepository: pairing);

  test('opens on Juntos', () {
    expect(build().state.section, CoupleSection.together);
  });

  test('select opens the other part and keeps the rest', () {
    final cubit = build()..select(CoupleSection.memories);

    expect(cubit.state.section, CoupleSection.memories);
  });

  test('a failed read leaves the chip plain', () async {
    when(history.getOverview).thenThrow(Exception('offline'));
    when(pairing.getPartner).thenAnswer(
      (_) async => const Profile(id: 'p', avatarKind: AvatarKind.initials, displayName: 'Rui'),
    );
    final cubit = build();

    await cubit.load();

    expect(cubit.state.togetherSince, isNull);
    expect(cubit.state.hasPartner, isFalse);
  });
}
