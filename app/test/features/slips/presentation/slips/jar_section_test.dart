import 'package:app/features/slips/data/models/drawn_slip.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/slips/cubit/jar_cubit.dart';
import 'package:app/features/slips/presentation/slips/cubit/slips_list_cubit.dart';
import 'package:app/features/slips/presentation/slips/widgets/jar_section.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  late SlipRepository repository;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    repository = _MockSlipRepository();
    AppInjector.instance.registerFactory<JarCubit>(() => JarCubit(slipRepository: repository));
    addTearDown(() => AppInjector.instance.unregister<JarCubit>());
  });

  Future<SlipsListCubit> pump(WidgetTester tester) async {
    final list = SlipsListCubit(slipRepository: repository);
    addTearDown(list.close);
    await tester.pumpApp(BlocProvider.value(value: list, child: const JarSection()));
    await tester.pump();
    await tester.pump();

    return list;
  }

  testWidgets('the drawn slip shows and another can be drawn', (tester) async {
    when(() => repository.drawFromJar())
        .thenAnswer((_) async => const DrawnSlip(id: 's1', body: 'Fez café'));

    await pump(tester);

    expect(find.text('Fez café'), findsOneWidget);
    expect(find.text('Outro'), findsOneWidget);
  });

  testWidgets('an empty jar says so and sends the person to their slips', (tester) async {
    when(() => repository.drawFromJar()).thenAnswer((_) async => null);

    await pump(tester);

    expect(find.text('O potinho está vazio'), findsOneWidget);
    expect(find.text('Ver meus slips'), findsOneWidget);
  });
}
