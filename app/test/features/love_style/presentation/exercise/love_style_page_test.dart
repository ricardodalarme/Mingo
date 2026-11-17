import 'package:app/features/love_style/data/models/love_style_entry.dart';
import 'package:app/features/love_style/data/repositories/love_style_repository.dart';
import 'package:app/features/love_style/presentation/exercise/cubit/love_style_cubit.dart';
import 'package:app/features/love_style/presentation/exercise/love_style_page.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockLoveStyleRepository() extends Mock implements LoveStyleRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

void main() {
  late LoveStyleRepository repository;
  late PairingRepository pairingRepository;

  const ranked = ['touch', 'time', 'words', 'acts', 'gifts'];

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    repository = _MockLoveStyleRepository();
    pairingRepository = _MockPairingRepository();
    when(() => repository.getOverview()).thenAnswer((_) async => const LoveStyleOverview());
    when(() => repository.getManualEntry()).thenAnswer((_) async => null);
    when(() => repository.saveRanked(any())).thenAnswer((_) async => 'q1');
    when(() => repository.saveManualEntry(any())).thenAnswer((_) async {
      return;
    });
    when(
      () => repository.setShared(
        id: any(named: 'id'),
        isShared: any(named: 'isShared'),
      ),
    ).thenAnswer((_) async {
      return;
    });
    when(() => pairingRepository.getPartner()).thenAnswer(
      (_) async => const Profile(id: 'p1', avatarKind: AvatarKind.initials, displayName: 'Marina'),
    );
  });

  Future<LoveStyleCubit> completedCubit() async {
    final cubit = LoveStyleCubit(repository: repository, pairingRepository: pairingRepository);
    await cubit.load();
    for (var question = 0; question < 6; question++) {
      cubit.select('touch');
      await cubit.next();
    }

    return cubit;
  }

  Future<LoveStyleCubit> resultCubit({DateTime? sharedAt, LoveStyleEntry? partner}) async {
    when(() => repository.getOverview()).thenAnswer(
      (_) async => LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: ranked, sharedAt: sharedAt),
        partner: partner,
      ),
    );
    final cubit = LoveStyleCubit(repository: repository, pairingRepository: pairingRepository);
    await cubit.load();

    return cubit;
  }

  testWidgets('the result ranks what fits the person best without a score', (tester) async {
    final cubit = await completedCubit();
    addTearDown(cubit.close);
    expect(cubit.state.partnerName, 'Marina');

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStylePage()));
    await tester.pump();

    expect(find.textContaining('O que faz você se sentir'), findsOneWidget);
    expect(find.text('amado'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Toque e abraço'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('Tempo só nosso'), findsOneWidget);
    expect(find.text('Salvar no Meu manual'), findsOneWidget);
    expect(find.text('Mostrar para Marina'), findsOneWidget);
    expect(find.textContaining(RegExp(r'\d+%|pontuação|ranking')), findsNothing);
  });

  testWidgets('saving to the manual sends no haptic or notification platform call', (tester) async {
    final cubit = await completedCubit();
    addTearDown(cubit.close);
    final calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (
      call,
    ) async {
      calls.add(call);

      return null;
    });
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStylePage()));
    await tester.pump();
    await tester.tap(find.text('Salvar no Meu manual'));
    await tester.pump();
    await tester.pump();

    expect(find.text('Salvo no Meu manual.'), findsOneWidget);
    expect(find.text('Salvo no Meu manual'), findsOneWidget);
    expect(
      calls.where(
        (call) =>
            call.method == 'HapticFeedback.vibrate' ||
            call.method.toLowerCase().contains('notification'),
      ),
      isEmpty,
    );
  });

  testWidgets('sharing asks first and explains what the partner sees', (tester) async {
    final cubit = await completedCubit();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStylePage()));
    await tester.pump();
    await tester.tap(find.text('Mostrar para Marina'));
    await tester.pumpAndSettle();

    expect(find.text('Mostrar para Marina?'), findsOneWidget);
    expect(
      find.text(
        'Só o resultado aparece, nunca as suas respostas. Marina recebe um aviso '
        'e pode escolher não responder nada.',
      ),
      findsOneWidget,
    );
    expect(find.text('Agora não'), findsOneWidget);

    await tester.tap(find.text('Mostrar'));
    await tester.pumpAndSettle();

    verify(() => repository.setShared(id: 'q1', isShared: true)).called(1);
    expect(find.text('Deixar de mostrar para Marina'), findsOneWidget);
    expect(find.text('Mostrar para Marina'), findsNothing);
  });

  testWidgets('cancelling the confirmation shares nothing', (tester) async {
    final cubit = await completedCubit();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStylePage()));
    await tester.pump();
    await tester.tap(find.text('Mostrar para Marina'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Agora não'));
    await tester.pumpAndSettle();

    verifyNever(
      () => repository.setShared(
        id: any(named: 'id'),
        isShared: any(named: 'isShared'),
      ),
    );
    expect(find.text('Mostrar para Marina'), findsOneWidget);
  });

  testWidgets('a shared result with a shared partner result offers the comparison', (tester) async {
    final cubit = await resultCubit(
      sharedAt: DateTime.utc(2026, 3),
      partner: const LoveStyleEntry(id: 'q2', ranked: ranked),
    );
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStylePage()));
    await tester.pump();

    expect(find.text('Comparar os dois'), findsOneWidget);
    expect(find.text('Deixar de mostrar para Marina'), findsOneWidget);
  });

  testWidgets('a paired person with no display name can still share', (tester) async {
    when(() => pairingRepository.getPartner())
        .thenAnswer((_) async => const Profile(id: 'p1', avatarKind: AvatarKind.initials));
    final cubit = await completedCubit();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStylePage()));
    await tester.pump();

    expect(find.text('Mostrar para seu par'), findsOneWidget);
  });

  testWidgets('an unpaired person sees the invite instead of the share action', (tester) async {
    when(() => pairingRepository.getPartner()).thenAnswer((_) async => null);
    final cubit = await completedCubit();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStylePage()));
    await tester.pump();

    expect(
      find.text('Fica só com você. Quando alguém entrar, você decide se mostra.'),
      findsOneWidget,
    );
    expect(find.text('Convidar minha pessoa'), findsOneWidget);
    expect(find.text('Mostrar para Marina'), findsNothing);
  });

  testWidgets('a pairing failure offers a retry instead of looking unpaired', (tester) async {
    when(() => pairingRepository.getPartner())
        .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = await completedCubit();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStylePage()));
    await tester.pump();

    expect(find.text('Não deu para verificar seu par agora.'), findsOneWidget);
    expect(find.text('Tentar de novo'), findsOneWidget);
    expect(find.text('Convidar minha pessoa'), findsNothing);
  });

  testWidgets('a failed read shows a retry instead of a new exercise', (tester) async {
    when(() => repository.getOverview()).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = LoveStyleCubit(repository: repository, pairingRepository: pairingRepository);
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const LoveStylePage()));
    await tester.pump();

    expect(find.text('Não deu para carregar'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
    expect(find.text('Próxima'), findsNothing);
  });
}
