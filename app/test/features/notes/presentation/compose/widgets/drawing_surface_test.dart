import 'dart:typed_data';

import 'package:app/features/notes/data/models/sent_message.dart';
import 'package:app/features/notes/data/repositories/notes_repository.dart';
import 'package:app/features/notes/presentation/compose/cubit/compose_cubit.dart';
import 'package:app/features/notes/presentation/compose/widgets/drawing_surface.dart';
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

  Future<ComposeCubit> pumpSurface(WidgetTester tester) async {
    final cubit =
        ComposeCubit(
            notesRepository: repository,
            pairingRepository: pairingRepository,
            exportDrawing: (_) async => Uint8List(0),
          )
          ..onKindChanged(MessageKind.drawing)
          ..onStrokeStarted(const Offset(0.1, 0.1))
          ..startDrawing();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const DrawingSurface()));
    await tester.pump();
    return cubit;
  }

  testWidgets('the drawing mode has no scrollable ancestor', (tester) async {
    await pumpSurface(tester);

    expect(find.byType(Scrollable), findsNothing);
  });

  testWidgets('the way out finishes drawing with the strokes kept', (tester) async {
    final cubit = await pumpSurface(tester);

    await tester.tap(find.text('Concluído'));
    await tester.pump();

    expect(cubit.state.isDrawing, isFalse);
    expect(cubit.state.strokes, hasLength(1));
  });

  testWidgets('the system back leaves drawing instead of the page', (tester) async {
    final cubit = await pumpSurface(tester);

    await tester.binding.handlePopRoute();
    await tester.pump();

    expect(cubit.state.isDrawing, isFalse);
  });

  testWidgets('undo removes the last stroke', (tester) async {
    final cubit = await pumpSurface(tester);

    await tester.tap(find.text('Desfazer'));
    await tester.pump();

    expect(cubit.state.strokes, isEmpty);
  });
}
