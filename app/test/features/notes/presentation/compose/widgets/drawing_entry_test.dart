import 'dart:typed_data';

import 'package:app/features/notes/data/models/sent_message.dart';
import 'package:app/features/notes/data/repositories/notes_repository.dart';
import 'package:app/features/notes/presentation/compose/cubit/compose_cubit.dart';
import 'package:app/features/notes/presentation/compose/widgets/drawing_canvas.dart';
import 'package:app/features/notes/presentation/compose/widgets/drawing_entry.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockNotesRepository() extends Mock implements NotesRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

void main() {
  late NotesRepository repository;
  late PairingRepository pairingRepository;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    repository = _MockNotesRepository();
    pairingRepository = _MockPairingRepository();
  });

  ComposeCubit build() => ComposeCubit(
    notesRepository: repository,
    pairingRepository: pairingRepository,
    exportDrawing: (_) async => Uint8List(0),
  );

  Future<ComposeCubit> pumpEntry(WidgetTester tester, {ComposeCubit? cubit}) async {
    final resolved = cubit ?? build();
    addTearDown(resolved.close);
    await tester.pumpApp(
      BlocProvider.value(
        value: resolved,
        child: const BaseView(
          appBar: null,
          body: Center(child: SizedBox(width: 300, child: DrawingEntry())),
        ),
      ),
    );
    await tester.pump();
    return resolved;
  }

  testWidgets('an empty drawing asks to start one', (tester) async {
    final cubit = await pumpEntry(tester);

    expect(find.byType(DrawingPaper), findsNothing);
    expect(find.text('Faça um traço para poder enviar.'), findsOneWidget);

    await tester.tap(find.text('Desenhar'));
    await tester.pump();

    expect(cubit.state.isDrawing, isTrue);
  });

  testWidgets('a started drawing is previewed and can be continued', (tester) async {
    final cubit = build()
      ..onKindChanged(MessageKind.drawing)
      ..onStrokeStarted(const Offset(0.1, 0.1));
    await pumpEntry(tester, cubit: cubit);

    expect(find.byType(DrawingPaper), findsOneWidget);

    await tester.tap(find.text('Continuar desenhando'));
    await tester.pump();

    expect(cubit.state.isDrawing, isTrue);
    expect(cubit.state.strokes, hasLength(1));
  });
}
