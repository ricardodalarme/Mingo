import 'package:app/features/quizzes/data/models/quiz_kind.dart';
import 'package:app/features/quizzes/data/models/quizzes_progress.dart';
import 'package:app/features/quizzes/data/repositories/quizzes_repository.dart';
import 'package:app/features/quizzes/presentation/hub/cubit/quizzes_cubit.dart';
import 'package:app/features/quizzes/presentation/hub/quizzes_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockQuizzesRepository() extends Mock implements QuizzesRepository;

void main() {
  late QuizzesRepository repository;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() => repository = _MockQuizzesRepository());

  Future<QuizzesCubit> loaded(QuizzesProgress progress) async {
    when(() => repository.getProgress()).thenAnswer((_) async => progress);
    final cubit = QuizzesCubit(repository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    return cubit;
  }

  testWidgets('lists the two quizzes with when each one was finished', (tester) async {
    final cubit = await loaded(QuizzesProgress(doneAt: {QuizKind.loved: DateTime(2026, 11, 3)}));

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuizzesPage()));
    await tester.pump();

    expect(find.textContaining('Se conhecer'), findsOneWidget);
    expect(find.text('Como eu me sinto amado'), findsOneWidget);
    expect(find.text('Como eu reajo numa briga'), findsOneWidget);
    expect(find.text('6 perguntas · 2 min'), findsNWidgets(2));
    expect(find.text('Feito em 3 nov'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
    expect(
      find.text('Só você vê o resultado, até você tocar em Mostrar. Não é teste psicológico.'),
      findsOneWidget,
    );
  });

  testWidgets('a failed read offers to try again', (tester) async {
    when(() => repository.getProgress()).thenThrow(Exception('offline'));
    final cubit = QuizzesCubit(repository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuizzesPage()));
    await tester.pump();

    expect(find.text('Não deu para abrir os quizzes'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
    expect(find.text('Como eu me sinto amado'), findsNothing);
  });

  testWidgets('a person who never answered sees both quizzes ready to start', (tester) async {
    final cubit = await loaded(const QuizzesProgress());

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuizzesPage()));
    await tester.pump();

    expect(find.text('Começar'), findsNWidgets(2));
    expect(find.textContaining('Feito em'), findsNothing);
  });
}
