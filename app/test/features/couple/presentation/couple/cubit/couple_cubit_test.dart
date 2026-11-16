import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('opens on Juntos', () {
    expect(CoupleCubit().state.section, CoupleSection.together);
  });

  blocTest<CoupleCubit, CoupleState>(
    'select opens the other part',
    build: CoupleCubit.new,
    act: (cubit) => cubit.select(CoupleSection.memories),
    expect: () => [const CoupleState(section: CoupleSection.memories)],
  );
}
