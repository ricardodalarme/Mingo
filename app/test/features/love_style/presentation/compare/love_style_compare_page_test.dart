import 'package:app/features/love_style/data/models/love_style_entry.dart';
import 'package:app/features/love_style/data/repositories/love_style_repository.dart';
import 'package:app/features/love_style/presentation/compare/cubit/love_style_compare_cubit.dart';
import 'package:app/features/love_style/presentation/compare/love_style_compare_page.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockLoveStyleRepository() extends Mock implements LoveStyleRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

void main() {
  late LoveStyleRepository repository;
  late PairingRepository pairingRepository;

  const mine = ['time', 'words', 'acts', 'gifts', 'touch'];
  const theirs = ['touch', 'time', 'words', 'acts', 'gifts'];

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    repository = _MockLoveStyleRepository();
    pairingRepository = _MockPairingRepository();
    when(() => pairingRepository.getPartner()).thenAnswer(
      (_) async => const Profile(id: 'p1', avatarKind: AvatarKind.initials, displayName: 'Marina'),
    );
  });

  Future<LoveStyleCompareCubit> loaded(LoveStyleOverview overview) async {
    when(() => repository.getOverview()).thenAnswer((_) async => overview);
    final cubit = LoveStyleCompareCubit(
      repository: repository,
      pairingRepository: pairingRepository,
    );
    addTearDown(cubit.close);
    await cubit.load();

    return cubit;
  }

  testWidgets('shows both rankings and what they have in common', (tester) async {
    final cubit = await loaded(
      LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: mine, sharedAt: DateTime.utc(2026, 3)),
        partner: const LoveStyleEntry(id: 'q2', ranked: theirs),
      ),
    );

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStyleComparePage()));
    await tester.pump();

    expect(find.text('Vocês dois'), findsOneWidget);
    expect(find.textContaining('O que faz vocês se sentirem'), findsOneWidget);
    expect(find.text('VOCÊ'), findsOneWidget);
    expect(find.text('MARINA'), findsOneWidget);
    expect(find.text('Mais importante'), findsNWidgets(2));
    expect(find.text('Tempo só nosso'), findsNWidgets(2));
    expect(find.text('Toque e abraço'), findsOneWidget);
    expect(find.text('EM COMUM'), findsOneWidget);
    expect(find.text('Os dois valorizam tempo só nosso.'), findsOneWidget);
    expect(find.text('Planejar um tempo só nosso'), findsOneWidget);
    expect(find.textContaining(RegExp(r'\d+%|pontuação|ranking')), findsNothing);
  });

  testWidgets('a comparison that is not ready yet says so honestly', (tester) async {
    final cubit = await loaded(
      const LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: mine),
      ),
    );

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStyleComparePage()));
    await tester.pump();

    expect(find.text('A comparação ainda não está pronta'), findsOneWidget);
    expect(find.text('Ela aparece quando os dois mostrarem o resultado.'), findsOneWidget);
    expect(find.text('Planejar um tempo só nosso'), findsNothing);
  });

  testWidgets('a failed read offers to try again', (tester) async {
    when(() => repository.getOverview()).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = LoveStyleCompareCubit(
      repository: repository,
      pairingRepository: pairingRepository,
    );
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStyleComparePage()));
    await tester.pump();

    expect(find.text('Não deu para carregar'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
  });
}
