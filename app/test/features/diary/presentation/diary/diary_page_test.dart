import 'dart:async';

import 'package:app/features/diary/data/models/diary_entry.dart';
import 'package:app/features/diary/data/repositories/diary_repository.dart';
import 'package:app/features/diary/presentation/diary/cubit/diary_cubit.dart';
import 'package:app/features/diary/presentation/diary/diary_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockDiaryRepository() extends Mock implements DiaryRepository;

void main() {
  late DiaryRepository repository;

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    repository = _MockDiaryRepository();
  });

  Future<DiaryCubit> loaded() async {
    final cubit = DiaryCubit(repository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    return cubit;
  }

  testWidgets('the diary says it is private and starts on today', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      when(() => repository.getEntries()).thenAnswer(
        (_) async => [
          DiaryEntry(
            id: 'j1',
            entryDate: clock.now(),
            body: 'Hoje eu me senti em paz.',
            mood: 'calm',
          ),
        ],
      );
      final cubit = await loaded();

      await tester.pumpApp(BlocProvider.value(value: cubit, child: const DiaryPage()));
      await tester.pump();

      expect(find.text('Só eu. Nunca é compartilhado.'), findsOneWidget);
      expect(find.text('Hoje eu me senti...'), findsWidgets);
      expect(find.text('Em paz'), findsOneWidget);
      expect(find.text('Cansado(a)'), findsOneWidget);
      expect(find.textContaining('Hoje eu me senti em paz.'), findsWidgets);
    });
  });

  testWidgets('an empty diary invites a first entry', (tester) async {
    when(() => repository.getEntries()).thenAnswer((_) async => []);
    final cubit = await loaded();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const DiaryPage()));
    await tester.pump();

    expect(find.text('Nada escrito ainda'), findsOneWidget);
    expect(find.text('Salvar'), findsOneWidget);
  });

  testWidgets('a failed save keeps the typed text', (tester) async {
    when(() => repository.getEntries()).thenAnswer((_) async => []);
    when(
      () => repository.saveEntry(
        entryDate: any(named: 'entryDate'),
        body: 'Não quero perder isto',
        mood: null,
        id: null,
      ),
    ).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = await loaded();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const DiaryPage()));
    await tester.pump();
    await tester.enterText(find.byType(EditableText), 'Não quero perder isto');
    await tester.pump();
    await tester.tap(find.text('Salvar'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      tester.widget<EditableText>(find.byType(EditableText)).controller.text,
      'Não quero perder isto',
    );
    expect(find.text('Não deu para salvar agora. Seu texto continua aqui.'), findsOneWidget);

    await tester.pump(const Duration(seconds: 7));
  });

  testWidgets('text typed while the diary loads is never wiped', (tester) async {
    final response = Completer<List<DiaryEntry>>();
    when(() => repository.getEntries()).thenAnswer((_) => response.future);
    final cubit = DiaryCubit(repository: repository);
    addTearDown(cubit.close);
    final loading = cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const DiaryPage()));
    await tester.pump();
    await tester.enterText(find.byType(EditableText), 'Escrito antes de carregar.');
    await tester.pump();

    response.complete([]);
    await loading;
    await tester.pump();

    expect(
      tester.widget<EditableText>(find.byType(EditableText)).controller.text,
      'Escrito antes de carregar.',
    );
  });
}
