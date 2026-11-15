import 'dart:typed_data';

import 'package:app/features/share/data/repositories/share_image_repository.dart';
import 'package:app/features/share/presentation/sheet/cubit/share_sheet_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockShareImageRepository() extends Mock implements ShareImageRepository;

void main() {
  late ShareImageRepository repository;
  late ShareSheetCubit cubit;

  setUpAll(() => registerFallbackValue(Uint8List(0)));

  setUp(() {
    repository = _MockShareImageRepository();
    cubit = ShareSheetCubit(repository: repository);
  });

  tearDown(() => cubit.close());

  test('starts on the first card with no action running', () {
    expect(cubit.state, const ShareSheetState());
  });

  test('selecting a card keeps it for the preview', () {
    cubit.onSelected(1);

    expect(cubit.state.selectedIndex, 1);
  });

  blocTest<ShareSheetCubit, ShareSheetState>(
    'shares the captured image and goes back to idle',
    build: () {
      when(() => repository.share(any())).thenAnswer((_) async {});

      return cubit;
    },
    act: (cubit) => cubit.share(() async => Uint8List.fromList([1, 2, 3])),
    expect: () => [
      const ShareSheetState(shareAction: Loading()),
      const ShareSheetState(shareAction: Success<void>(null)),
      const ShareSheetState(),
    ],
    verify: (_) {
      final png = verify(() => repository.share(captureAny())).captured.single as Uint8List;
      expect(png, [1, 2, 3]);
    },
  );

  blocTest<ShareSheetCubit, ShareSheetState>(
    'a failed capture is reported as a failure and the action is released',
    build: () => cubit,
    act: (cubit) => cubit.share(() async => throw Exception('no layer')),
    expect: () => [
      const ShareSheetState(shareAction: Loading()),
      const ShareSheetState(shareAction: Failure(UnknownException())),
      const ShareSheetState(),
    ],
    verify: (_) => verifyNever(() => repository.share(any())),
  );

  blocTest<ShareSheetCubit, ShareSheetState>(
    'a failed share is reported as a failure and the action is released',
    build: () {
      when(() => repository.share(any())).thenThrow(Exception('no share sheet'));

      return cubit;
    },
    act: (cubit) => cubit.share(() async => Uint8List(0)),
    expect: () => [
      const ShareSheetState(shareAction: Loading()),
      const ShareSheetState(shareAction: Failure(UnknownException())),
      const ShareSheetState(),
    ],
  );

  blocTest<ShareSheetCubit, ShareSheetState>(
    'a second tap while sharing does not share again',
    build: () {
      when(() => repository.share(any())).thenAnswer((_) async {});

      return cubit;
    },
    act: (cubit) async {
      final first = cubit.share(() async => Uint8List(0));
      await cubit.share(() async => Uint8List(0));
      await first;
    },
    verify: (_) => verify(() => repository.share(any())).called(1),
  );
}
