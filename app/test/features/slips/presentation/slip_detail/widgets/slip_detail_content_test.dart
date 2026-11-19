import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_detail.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/slip_detail/cubit/slip_detail_cubit.dart';
import 'package:app/features/slips/presentation/slip_detail/widgets/slip_detail_content.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  setUpAll(() {
    registerFallbackValue(
      SlipDetail(
        id: 's1',
        body: 'Fez café',
        kind: SlipKind.quick,
        createdAt: DateTime(2026, 11, 3),
        forCard: false,
      ),
    );
    LocaleSettings.setLocaleSync(AppLocale.pt);
  });

  late SlipRepository repository;

  final slip = SlipDetail(
    id: 's1',
    body: 'Ela ficou acordada para me levar',
    kind: SlipKind.quick,
    createdAt: DateTime(2026, 11, 3),
    forCard: false,
    category: SlipCategory.did,
  );

  setUp(() {
    repository = _MockSlipRepository();
    when(() => repository.getSlip('s1')).thenAnswer((_) async => slip);
    when(() => repository.updateSlip(any())).thenAnswer((_) async {});
  });

  Future<SlipDetailCubit> build(WidgetTester tester) async {
    final cubit = SlipDetailCubit(slipRepository: repository);
    addTearDown(cubit.close);
    await cubit.load('s1');

    await tester.pumpApp(
      BaseView(
        appBar: null,
        body: BlocProvider.value(value: cubit, child: const SlipDetailContent()),
      ),
    );
    await tester.pump();

    return cubit;
  }

  testWidgets('the detail shows the board blocks and the two actions', (tester) async {
    await build(tester);

    expect(find.text('Ela ficou acordada para me levar'), findsOneWidget);
    expect(find.byType(BaseSlipNote), findsOneWidget);
    expect(find.text('FEZ ALGO'), findsOneWidget);
    expect(find.text('Data'), findsNothing);
    expect(find.text('Tipo'), findsNothing);
    expect(find.text('Visibilidade'), findsOneWidget);
    expect(find.text('Privado'), findsOneWidget);
    expect(find.text('Incluído no cartão'), findsOneWidget);
    expect(find.text('Não'), findsOneWidget);
    expect(find.text('Apagar'), findsOneWidget);
    expect(find.text('Editar'), findsOneWidget);
  });

  testWidgets('editing opens the slip text with save and cancel', (tester) async {
    await build(tester);

    await tester.tap(find.text('Editar'));
    await tester.pump();

    expect(find.byType(BaseSlipNoteField), findsOneWidget);
    expect(find.byType(BaseSlipNote), findsNothing);
    expect(find.text('Salvar'), findsOneWidget);
    expect(find.text('Cancelar'), findsOneWidget);
  });

  testWidgets('deleting first asks with the board copy', (tester) async {
    await build(tester);

    await tester.tap(find.text('Apagar'));
    await tester.pumpAndSettle();

    expect(find.text('Apagar este slip?'), findsOneWidget);
    expect(find.text('Será removido da sua semana e da linha do tempo.'), findsOneWidget);

    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(find.text('Apagar este slip?'), findsNothing);
  });

  testWidgets('visibility can move a slip out of the weekly card', (tester) async {
    when(() => repository.getSlip('s1')).thenAnswer((_) async => slip.copyWith(forCard: true));
    final cubit = await build(tester);

    expect(find.text('No cartão semanal'), findsOneWidget);
    expect(find.text('Sim'), findsOneWidget);

    await tester.tap(find.text('Visibilidade'));
    await tester.pumpAndSettle();
    expect(find.text('Quem vê este slip?'), findsOneWidget);
    expect(find.text('O padrão é privado.'), findsOneWidget);

    await tester.tap(find.text('Só eu'));
    await tester.pump();
    await tester.tap(find.text('Pronto'));
    await tester.pumpAndSettle();

    verify(() => repository.updateSlip(any())).called(1);
    expect(cubit.state.current?.forCard, isFalse);
  });

  testWidgets('a long slip and its actions fit at 200% text', (tester) async {
    when(() => repository.getSlip('s1')).thenAnswer(
      (_) async => slip.copyWith(
        body:
            'Ela ficou acordada comigo até tarde, mesmo depois de um dia inteiro de trabalho, '
            'só para eu conseguir terminar o que precisava e ainda me deixou um bilhete na mesa.',
      ),
    );
    final cubit = SlipDetailCubit(slipRepository: repository);
    addTearDown(cubit.close);
    await cubit.load('s1');

    await tester.pumpApp(
      Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(2)),
          child: BaseView(
            appBar: null,
            body: BlocProvider.value(value: cubit, child: const SlipDetailContent()),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
