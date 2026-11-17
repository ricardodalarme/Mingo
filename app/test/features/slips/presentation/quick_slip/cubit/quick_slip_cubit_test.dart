import 'package:app/features/annoyances/data/models/annoyance.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_draft.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/quick_slip/cubit/quick_slip_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mocktail/mocktail.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

class _MockAnnoyanceRepository() extends Mock implements AnnoyanceRepository;

void main() {
  late SlipRepository repository;
  late AnnoyanceRepository annoyances;

  setUpAll(() {
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    repository = _MockSlipRepository();
    annoyances = _MockAnnoyanceRepository();
    when(() => annoyances.save(any())).thenAnswer(
      (_) async => Annoyance(
        id: 'a1',
        body: 'Chegou tarde',
        createdAt: DateTime(2026),
        expiresAt: DateTime(2026, 1, 15),
      ),
    );
    when(() => annoyances.delete(any())).thenAnswer((_) async {});
    when(() => repository.readDraft(any())).thenReturn(null);
    when(() => repository.getForCardDefault()).thenAnswer((_) async => false);
    when(
      () => repository.saveDraft(
        text: any(named: 'text'),
        now: any(named: 'now'),
        category: any(named: 'category'),
      ),
    ).thenAnswer((_) async {
      return;
    });
    when(() => repository.clearDraft()).thenAnswer((_) async {
      return;
    });
    when(
      () => repository.saveQuick(
        id: any(named: 'id'),
        body: any(named: 'body'),
        createdAt: any(named: 'createdAt'),
        category: any(named: 'category'),
        forCard: any(named: 'forCard'),
      ),
    ).thenAnswer((_) async => SlipSaveOutcome.synced);
    when(() => repository.undo(any())).thenAnswer((_) async {
      return;
    });
  });

  QuickSlipCubit build() =>
      QuickSlipCubit(slipRepository: repository, annoyanceRepository: annoyances);

  blocTest<QuickSlipCubit, QuickSlipState>(
    'start restores a fresh draft',
    build: () {
      when(() => repository.readDraft(any())).thenReturn(
        SlipDraft(text: 'Fez café', savedAt: DateTime(2026), category: SlipCategory.did),
      );
      return build();
    },
    act: (cubit) => cubit.start(),
    expect: () => const [QuickSlipState(text: FormInput('Fez café'), category: SlipCategory.did)],
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'cannot save empty or over-long text',
    build: build,
    act: (cubit) async {
      await cubit.save();
      cubit.onTextChanged('a' * (quickSlipMaxLength + 1));
      await cubit.save();
    },
    verify: (_) => verifyNever(
      () => repository.saveQuick(
        id: any(named: 'id'),
        body: any(named: 'body'),
        createdAt: any(named: 'createdAt'),
        category: any(named: 'category'),
        forCard: any(named: 'forCard'),
      ),
    ),
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'a second tap on Save while saving sends one slip',
    build: build,
    act: (cubit) async {
      cubit.onTextChanged('Fez café');
      await Future.wait([cubit.save(), cubit.save()]);
    },
    verify: (_) => verify(
      () => repository.saveQuick(
        id: any(named: 'id'),
        body: 'Fez café',
        createdAt: any(named: 'createdAt'),
        category: any(named: 'category'),
        forCard: any(named: 'forCard'),
      ),
    ).called(1),
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'something that bothered the person is kept as an annoyance, never as a slip',
    build: build,
    act: (cubit) async {
      cubit
        ..onModeChanged(QuickSlipMode.annoyance)
        ..onTextChanged('Chegou tarde sem avisar');
      await cubit.save();
    },
    verify: (cubit) {
      verify(() => annoyances.save('Chegou tarde sem avisar')).called(1);
      verifyNever(
        () => repository.saveQuick(
          id: any(named: 'id'),
          body: any(named: 'body'),
          createdAt: any(named: 'createdAt'),
          category: any(named: 'category'),
          forCard: any(named: 'forCard'),
        ),
      );
      expect(cubit.savedAnnoyance?.id, 'a1');
    },
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'what bothered the person is never written to the device',
    build: build,
    act: (cubit) => cubit
      ..onModeChanged(QuickSlipMode.annoyance)
      ..onTextChanged('Chegou tarde sem avisar'),
    verify: (_) => verifyNever(
      () => repository.saveDraft(
        text: any(named: 'text'),
        now: any(named: 'now'),
        category: any(named: 'category'),
      ),
    ),
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'switching to an annoyance drops the category',
    build: build,
    seed: () => const QuickSlipState(category: SlipCategory.did),
    act: (cubit) => cubit.onModeChanged(QuickSlipMode.annoyance),
    expect: () => const [QuickSlipState(mode: QuickSlipMode.annoyance)],
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'undoing an annoyance deletes it',
    build: build,
    act: (cubit) async {
      cubit
        ..onModeChanged(QuickSlipMode.annoyance)
        ..onTextChanged('Chegou tarde sem avisar');
      await cubit.save();
      await cubit.undo();
    },
    verify: (_) {
      verify(() => annoyances.delete('a1')).called(1);
      verifyNever(() => repository.undo(any()));
    },
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'saving clears the draft and opens the undo window',
    build: build,
    act: (cubit) async {
      cubit.onTextChanged('Fez café');
      await cubit.save();
    },
    verify: (cubit) {
      expect(cubit.state.isSaved, isTrue);
      expect(cubit.state.canUndo, isTrue);
      verify(() => repository.clearDraft()).called(1);
    },
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'a failed save keeps the text and resets the action',
    build: () {
      when(
        () => repository.saveQuick(
          id: any(named: 'id'),
          body: any(named: 'body'),
          createdAt: any(named: 'createdAt'),
          category: any(named: 'category'),
        ),
      ).thenAnswer((_) async => throw const LocalizedException(l10nKey: 'RATE_LIMITED'));
      return build();
    },
    act: (cubit) async {
      cubit.onTextChanged('Fez café');
      await cubit.save();
    },
    verify: (cubit) {
      expect(cubit.state.text.value, 'Fez café');
      expect(cubit.state.saveAction, const Initial());
    },
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'undo removes the slip that was just saved',
    build: build,
    act: (cubit) async {
      cubit.onTextChanged('Fez café');
      await cubit.save();
      await cubit.undo();
    },
    verify: (cubit) {
      verify(() => repository.undo(any())).called(1);
      expect(cubit.state.undoAction, const Success<void>(null));
      expect(cubit.state.canUndo, isFalse);
    },
  );

  test('undoing takes the form back with the text still there', () async {
    final cubit = build();
    addTearDown(cubit.close);
    cubit.onTextChanged('Fez café');
    await cubit.save();
    await cubit.undo();

    expect(cubit.state.isSaved, isFalse);
    expect(cubit.state.text.value, 'Fez café');
  });

  test('a new slip starts private unless the person asked for the card', () async {
    final cubit = build();
    addTearDown(cubit.close);
    cubit.onTextChanged('Fez café');
    await cubit.save();

    verify(
      () => repository.saveQuick(
        id: any(named: 'id'),
        body: 'Fez café',
        createdAt: any(named: 'createdAt'),
        category: null,
        forCard: false,
      ),
    ).called(1);
  });

  test('a new slip follows the saved card preference', () async {
    when(() => repository.getForCardDefault()).thenAnswer((_) async => true);
    final cubit = build()..start();
    addTearDown(cubit.close);
    await Future<void>.delayed(Duration.zero);
    cubit.onTextChanged('Fez café');
    await cubit.save();

    verify(
      () => repository.saveQuick(
        id: any(named: 'id'),
        body: 'Fez café',
        createdAt: any(named: 'createdAt'),
        category: null,
        forCard: true,
      ),
    ).called(1);
  });

  test('a preference that cannot be read keeps the slip private', () async {
    when(() => repository.getForCardDefault()).thenThrow(Exception());
    final cubit = build()..start();
    addTearDown(cubit.close);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state.forCardByDefault, isFalse);
  });

  test('discarding clears the stored draft', () {
    final cubit = build()..onTextChanged('Rascunho');
    addTearDown(cubit.close);

    cubit.discardDraft();

    verify(() => repository.clearDraft()).called(1);
  });
}
