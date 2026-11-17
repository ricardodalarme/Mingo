import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:app/features/spice/presentation/cards/cubit/spice_cards_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSpiceRepository() extends Mock implements SpiceRepository;

void main() {
  late SpiceRepository spice;
  const card = SpiceCard(id: 'c1', text: 'Uma massagem', isMine: false);

  setUp(() {
    spice = _MockSpiceRepository();
    when(spice.getNextCard).thenAnswer((_) async => card);
    when(
      () => spice.respondToCard(
        id: any(named: 'id'),
        accept: any(named: 'accept'),
      ),
    ).thenAnswer((_) async {});
  });

  test('load shows the open card', () async {
    final cubit = SpiceCardsCubit(spiceRepository: spice);

    await cubit.load();

    expect(cubit.state.card, const Success<SpiceCard?>(card));
  });

  test('answering marks the card as answered, and the next load clears it', () async {
    final cubit = SpiceCardsCubit(spiceRepository: spice);
    await cubit.load();

    await cubit.respond(accept: true);

    verify(() => spice.respondToCard(id: 'c1', accept: true)).called(1);
    expect(cubit.state.isAnswered, isTrue);

    await cubit.load();
    expect(cubit.state.isAnswered, isFalse);
  });

  test('a failed answer keeps the card to answer again', () async {
    when(
      () => spice.respondToCard(
        id: any(named: 'id'),
        accept: any(named: 'accept'),
      ),
    ).thenThrow(Exception('offline'));
    final cubit = SpiceCardsCubit(spiceRepository: spice);
    await cubit.load();

    await cubit.respond(accept: false);

    expect(cubit.state.isAnswered, isFalse);
  });
}
