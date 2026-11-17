import 'package:app/features/memories/data/repositories/memories_repository.dart';
import 'package:app/features/memories/presentation/memories/cubit/on_this_day_cubit.dart';
import 'package:app/features/memories/presentation/memories/memories_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockMemoriesRepository() extends Mock implements MemoriesRepository;

void main() {
  late MemoriesRepository repository;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    repository = _MockMemoriesRepository();
    when(repository.getMemories).thenAnswer((_) async => []);
  });

  testWidgets('the menu lists the five things the couple keeps', (tester) async {
    AppInjector.instance.registerFactory<OnThisDayCubit>(
      () => OnThisDayCubit(memoriesRepository: repository),
    );
    addTearDown(() => AppInjector.instance.unregister<OnThisDayCubit>());
    await tester.pumpApp(const MemoriesPage());
    await tester.pump();

    expect(find.text('Linha do tempo'), findsOneWidget);
    expect(find.text('Potinho'), findsOneWidget);
    expect(find.text('Nossa história'), findsOneWidget);
    expect(find.text('Datas e números'), findsOneWidget);
    expect(find.text('Diário'), findsOneWidget);
    expect(find.text('Ideias de presente'), findsOneWidget);
  });
}
