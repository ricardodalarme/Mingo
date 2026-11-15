import 'dart:typed_data';

import 'package:app/features/notes/data/repositories/notes_repository.dart';
import 'package:app/features/notes/presentation/compose/cubit/compose_cubit.dart';
import 'package:app/features/notes/presentation/compose/widgets/drawing_canvas.dart';
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

  Future<ComposeCubit> pumpCanvas(WidgetTester tester) async {
    final cubit = build();
    addTearDown(cubit.close);
    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: const BaseView(
          appBar: null,
          body: Padding(
            padding: EdgeInsets.all(AppSpace.s16),
            child: AspectRatio(aspectRatio: 1, child: DrawingCanvas()),
          ),
        ),
      ),
    );
    await tester.pump();
    return cubit;
  }

  testWidgets('a drag paints one stroke', (tester) async {
    final cubit = await pumpCanvas(tester);

    await tester.drag(find.byType(DrawingCanvas), const Offset(60, 60));
    await tester.pump();

    expect(cubit.state.strokes, hasLength(1));
    expect(cubit.state.strokes.single.points.length, greaterThan(1));
  });
}
