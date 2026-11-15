import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_draft.dart';
import 'package:app/features/slips/data/models/slip_polarity.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/quick_slip/cubit/quick_slip_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:mocktail/mocktail.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  late SlipRepository repository;

  setUpAll(() {
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(SlipPolarity.liked);
  });

  setUp(() {
    repository = _MockSlipRepository();
    when(() => repository.readDraft(any())).thenReturn(null);
    when(
      () => repository.saveDraft(
        text: any(named: 'text'),
        now: any(named: 'now'),
        category: any(named: 'category'),
        polarity: any(named: 'polarity'),
        request: any(named: 'request'),
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
        request: any(named: 'request'),
      ),
    ).thenAnswer((_) async => SlipSaveOutcome.synced);
    when(() => repository.undo(any())).thenAnswer((_) async {
      return;
    });
  });

  QuickSlipCubit build() => QuickSlipCubit(slipRepository: repository);

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
        request: any(named: 'request'),
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
        request: any(named: 'request'),
      ),
    ).called(1),
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'a bothered slip is saved with its polarity',
    build: build,
    act: (cubit) async {
      cubit
        ..onPolarityChanged(SlipPolarity.bothered)
        ..onTextChanged('Chegou tarde sem avisar');
      await cubit.save();
    },
    verify: (_) => verify(
      () => repository.saveQuick(
        id: any(named: 'id'),
        body: 'Chegou tarde sem avisar',
        createdAt: any(named: 'createdAt'),
        category: any(named: 'category'),
        polarity: SlipPolarity.bothered,
        request: any(named: 'request'),
      ),
    ).called(1),
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'a bothered slip is saved with its gentle request',
    build: build,
    act: (cubit) async {
      cubit
        ..onPolarityChanged(SlipPolarity.bothered)
        ..onTextChanged('Chegou tarde sem avisar')
        ..onRequestChanged('  Poderia me avisar antes?  ');
      await cubit.save();
    },
    verify: (_) => verify(
      () => repository.saveQuick(
        id: any(named: 'id'),
        body: 'Chegou tarde sem avisar',
        createdAt: any(named: 'createdAt'),
        category: any(named: 'category'),
        polarity: SlipPolarity.bothered,
        request: 'Poderia me avisar antes?',
      ),
    ).called(1),
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'a request over the limit is refused',
    build: build,
    act: (cubit) async {
      cubit
        ..onPolarityChanged(SlipPolarity.bothered)
        ..onTextChanged('Chegou tarde')
        ..onRequestChanged('a' * (slipRequestMaxLength + 1));
      await cubit.save();
    },
    verify: (_) => verifyNever(
      () => repository.saveQuick(
        id: any(named: 'id'),
        body: any(named: 'body'),
        createdAt: any(named: 'createdAt'),
        category: any(named: 'category'),
        polarity: any(named: 'polarity'),
        request: any(named: 'request'),
      ),
    ),
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'the polarity is kept in the draft',
    build: build,
    act: (cubit) => cubit.onPolarityChanged(SlipPolarity.bothered),
    verify: (_) => verify(
      () => repository.saveDraft(
        text: any(named: 'text'),
        now: any(named: 'now'),
        category: any(named: 'category'),
        polarity: SlipPolarity.bothered,
        request: any(named: 'request'),
      ),
    ).called(1),
  );

  blocTest<QuickSlipCubit, QuickSlipState>(
    'going back to liked drops the request',
    build: build,
    act: (cubit) {
      cubit
        ..onPolarityChanged(SlipPolarity.bothered)
        ..onRequestChanged('Poderia me avisar antes?')
        ..onPolarityChanged(SlipPolarity.liked);
    },
    verify: (cubit) => expect(cubit.state.request.value, isEmpty),
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
          request: any(named: 'request'),
        ),
      ).thenAnswer((_) async => throw const LocalizedException(l10nKey: 'FREE_LIMIT_REACHED'));
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

  test('discarding clears the stored draft', () {
    final cubit = build()..onTextChanged('Rascunho');
    addTearDown(cubit.close);

    cubit.discardDraft();

    verify(() => repository.clearDraft()).called(1);
  });
}
