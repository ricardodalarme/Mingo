import 'package:app/features/_shared/presentation/forms/discard_changes.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/quick_slip/cubit/quick_slip_cubit.dart';
import 'package:app/features/slips/presentation/quick_slip/quick_slip_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

class _MockAnnoyanceRepository() extends Mock implements AnnoyanceRepository;

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
  });

  testWidgets('an unsaved quick slip is guarded before leaving', (tester) async {
    final repository = _MockSlipRepository();
    when(() => repository.readDraft(any())).thenReturn(null);
    // ignore: unnecessary_lambdas, a tearoff would run the mock before `when` captures it
    when(() => repository.getForCardDefault()).thenAnswer((_) => Future.syncValue(false));
    when(
      () => repository.saveDraft(
        text: any(named: 'text'),
        now: any(named: 'now'),
        category: any(named: 'category'),
      ),
    ).thenAnswer((_) async {
      return;
    });
    final cubit =
        QuickSlipCubit(slipRepository: repository, annoyanceRepository: _MockAnnoyanceRepository())
          ..start()
          ..onTextChanged('Fez café');
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();

    expect(tester.widget<DirtyFormGuard>(find.byType(DirtyFormGuard)).isDirty, isTrue);
  });

  testWidgets('a new slip starts as a good thing, with the switch to what bothered', (
    tester,
  ) async {
    final repository = _MockSlipRepository();
    when(() => repository.readDraft(any())).thenReturn(null);
    // ignore: unnecessary_lambdas, a tearoff would run the mock before `when` captures it
    when(() => repository.getForCardDefault()).thenAnswer((_) => Future.syncValue(false));
    final cubit = QuickSlipCubit(
      slipRepository: repository,
      annoyanceRepository: _MockAnnoyanceRepository(),
    )..start();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();

    expect(find.text('Gostei'), findsOneWidget);
    expect(find.text('Me incomodou'), findsOneWidget);
    expect(cubit.state.mode, QuickSlipMode.liked);
  });

  testWidgets('the good slip offers the four kinds and the private cue', (tester) async {
    final cubit = _buildCubit(_savingRepository());
    addTearDown(cubit.close);
    cubit.start();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();

    expect(find.text('Disse algo'), findsOneWidget);
    expect(find.text('Fez algo'), findsOneWidget);
    expect(find.text('Me notou'), findsOneWidget);
    expect(find.text('Me ajudou'), findsOneWidget);
    expect(
      find.text('Fica privado. No domingo você escolhe o que vai para o cartão.'),
      findsOneWidget,
    );
    expect(find.text('Adicionar detalhes'), findsOneWidget);
    expect(find.text('Salvar'), findsOneWidget);
  });

  testWidgets('something that bothered shows its own cue and no kinds', (tester) async {
    final cubit = _buildCubit(_savingRepository());
    addTearDown(cubit.close);
    cubit.start();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();
    await tester.tap(find.text('Me incomodou'));
    await tester.pump();

    expect(cubit.state.mode, QuickSlipMode.annoyance);
    expect(
      find.text(
        'Fica só com você e some sozinho em 14 dias. Nunca vai para o cartão. '
        'Só continua se você transformar em um pedido gentil.',
      ),
      findsOneWidget,
    );
    expect(find.text('Pedido gentil'), findsOneWidget);
    expect(find.text('Guardar'), findsOneWidget);
    expect(find.text('Disse algo'), findsNothing);
  });

  testWidgets('a slip kept for later says when it will be sent', (tester) async {
    final cubit = _buildCubit(_savingRepository(outcome: SlipSaveOutcome.queued));
    addTearDown(cubit.close);
    cubit
      ..start()
      ..onTextChanged('Fez café sem eu pedir');
    await cubit.save();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();

    expect(find.text('Salvo neste celular. Enviamos quando a conexão voltar.'), findsOneWidget);
    expect(find.text('Desfazer por 30 segundos.'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('undo in the toast takes the form back', (tester) async {
    final repository = _savingRepository();
    final cubit = _buildCubit(repository);
    addTearDown(cubit.close);
    cubit
      ..start()
      ..onTextChanged('Fez café sem eu pedir');
    await cubit.save();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();
    await tester.tap(find.text('Desfazer'));
    await tester.pump();
    await tester.pump();

    verify(() => repository.undo(any())).called(1);
    expect(find.text('Desfazer por 30 segundos.'), findsNothing);
    expect(find.text('Salvar'), findsOneWidget);
  });

  testWidgets('the capture form fits at 200% text', (tester) async {
    final cubit = _buildCubit(_savingRepository());
    addTearDown(cubit.close);
    cubit.start();

    await tester.pumpApp(
      Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(2)),
          child: BlocProvider.value(value: cubit, child: const QuickSlipPage()),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}

QuickSlipCubit _buildCubit(SlipRepository repository) =>
    QuickSlipCubit(slipRepository: repository, annoyanceRepository: _MockAnnoyanceRepository());

SlipRepository _savingRepository({SlipSaveOutcome outcome = SlipSaveOutcome.synced}) {
  final repository = _MockSlipRepository();
  when(() => repository.readDraft(any())).thenReturn(null);
  // ignore: unnecessary_lambdas, a tearoff would run the mock before `when` captures it
  when(() => repository.getForCardDefault()).thenAnswer((_) => Future.syncValue(false));
  // ignore: unnecessary_lambdas, a tearoff would run the mock before `when` captures it
  when(() => repository.clearDraft()).thenAnswer((_) async {});
  when(
    () => repository.saveDraft(
      text: any(named: 'text'),
      now: any(named: 'now'),
      category: any(named: 'category'),
    ),
  ).thenAnswer((_) async {});
  when(
    () => repository.saveQuick(
      id: any(named: 'id'),
      body: any(named: 'body'),
      createdAt: any(named: 'createdAt'),
      category: any(named: 'category'),
      forCard: any(named: 'forCard'),
    ),
  ).thenAnswer((_) async => outcome);
  when(() => repository.undo(any())).thenAnswer((_) async {});

  return repository;
}
