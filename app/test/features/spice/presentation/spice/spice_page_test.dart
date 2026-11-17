import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:app/features/spice/presentation/spice/cubit/spice_cubit.dart';
import 'package:app/features/spice/presentation/spice/spice_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockSpiceRepository() extends Mock implements SpiceRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

void main() {
  late SpiceRepository spice;
  late PairingRepository pairing;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    spice = _MockSpiceRepository();
    pairing = _MockPairingRepository();
    when(pairing.getPartner).thenAnswer(
      (_) async => const Profile(id: 'p', avatarKind: AvatarKind.initials, displayName: 'Rui'),
    );
  });

  Future<void> pump(WidgetTester tester, SpiceStage stage) async {
    when(spice.getStatus)
        .thenAnswer((_) async => SpiceStatus(stage: stage, myLevel: SpiceLevel.soft));
    final cubit = SpiceCubit(spiceRepository: spice, pairingRepository: pairing);
    addTearDown(cubit.close);
    await cubit.load();
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const SpicePage()));
    await tester.pump();
  }

  testWidgets('off shows the promises and asks the person to confirm being an adult', (
    tester,
  ) async {
    await pump(tester, SpiceStage.off);

    expect(find.text('Só vale quando vocês dois ligam.'), findsOneWidget);
    expect(find.text('Tenho 18 anos ou mais'), findsOneWidget);

    await tester.tap(find.text('Ligar'));
    await tester.pump();

    expect(find.text('Confirme para continuar.'), findsOneWidget);
    verifyNever(spice.turnOn);
  });

  testWidgets('waiting for the partner says nothing was announced', (tester) async {
    await pump(tester, SpiceStage.waitingPartner);

    expect(find.text('Esperando a outra pessoa'), findsOneWidget);
    expect(find.text('Desligar'), findsOneWidget);
  });

  testWidgets('on offers cards, desires, the challenge and the settings', (tester) async {
    await pump(tester, SpiceStage.on);

    expect(find.text('Cartas da noite'), findsOneWidget);
    expect(find.text('Desejos'), findsOneWidget);
    expect(find.text('Desafio da semana'), findsOneWidget);
    expect(find.text('Configurações'), findsOneWidget);
  });

  testWidgets('without a partner it says Tempero is for two', (tester) async {
    when(pairing.getPartner).thenAnswer((_) async => null);

    await pump(tester, SpiceStage.off);

    expect(find.text('O Tempero é a dois'), findsOneWidget);
  });
}
