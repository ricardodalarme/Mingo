import 'package:app/features/capsules/data/repositories/capsules_repository.dart';
import 'package:app/features/capsules/presentation/capsules/capsules_page.dart';
import 'package:app/features/capsules/presentation/capsules/cubit/capsules_cubit.dart';
import 'package:app/features/connect/data/repositories/connect_repository.dart';
import 'package:app/features/connect/presentation/us/cubit/us_cubit.dart';
import 'package:app/features/connect/presentation/us/us_page.dart';
import 'package:app/features/distance/data/models/distance_info.dart';
import 'package:app/features/distance/data/repositories/distance_repository.dart';
import 'package:app/features/distance/presentation/distance/cubit/distance_cubit.dart';
import 'package:app/features/distance/presentation/distance/distance_page.dart';
import 'package:app/features/notes/data/repositories/notes_repository.dart';
import 'package:app/features/notes/presentation/compose/compose_page.dart';
import 'package:app/features/notes/presentation/compose/cubit/compose_cubit.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/settings/data/models/settings.dart';
import 'package:app/features/settings/data/repositories/settings_repository.dart';
import 'package:app/features/settings/presentation/language/cubit/language_cubit.dart';
import 'package:app/features/settings/presentation/language/language_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helpers/pump_app.dart';

class _MockCapsules() extends Mock implements CapsulesRepository;

class _MockConnect() extends Mock implements ConnectRepository;

class _MockDistance() extends Mock implements DistanceRepository;

class _MockNotes() extends Mock implements NotesRepository;

class _MockPairing() extends Mock implements PairingRepository;

class _MockSettings() extends Mock implements SettingsRepository;

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));
  tearDownAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  Future<void> pumpNarrow(WidgetTester tester, Widget page) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.3)),
          child: page,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }

  testWidgets('the capsule page fits in English at a small width and large text', (tester) async {
    final repository = _MockCapsules();
    when(repository.getCapsules).thenAnswer((_) async => const []);
    final cubit = CapsulesCubit(capsulesRepository: repository);
    addTearDown(cubit.close);

    await pumpNarrow(tester, BlocProvider.value(value: cubit, child: const CapsulesPage()));

    expect(find.text('Time capsule'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the us page fits in English at a small width and large text', (tester) async {
    final cubit = UsCubit(connectRepository: _MockConnect());
    addTearDown(cubit.close);

    await pumpNarrow(tester, BlocProvider.value(value: cubit, child: const UsPage()));

    expect(find.text('Send with care'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the note page fits in English at a small width and large text', (tester) async {
    final repository = _MockNotes();
    final pairingRepository = _MockPairing();
    when(repository.getSent).thenAnswer((_) async => const []);
    when(pairingRepository.getPartner)
        .thenAnswer((_) async => const Profile(id: 'p1', avatarKind: AvatarKind.initials));
    final cubit = ComposeCubit(
      notesRepository: repository,
      pairingRepository: pairingRepository,
      exportDrawing: (_) async => throw UnimplementedError(),
    );
    addTearDown(cubit.close);

    await pumpNarrow(tester, BlocProvider.value(value: cubit, child: const ComposePage()));

    expect(find.text('A note or a drawing'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the distance page fits in English at a small width and large text', (tester) async {
    final repository = _MockDistance();
    when(repository.getDistance).thenAnswer((_) async => DistanceInfo.fake());
    final cubit = DistanceCubit(distanceRepository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    await pumpNarrow(tester, BlocProvider.value(value: cubit, child: const DistancePage()));

    expect(find.text('Distance'), findsOneWidget);
    expect(find.text('Your partner'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the language page fits in English at a small width and large text', (tester) async {
    final repository = _MockSettings();
    when(repository.get).thenReturn(const Settings.empty());
    final cubit = LanguageCubit(repository: repository);
    addTearDown(cubit.close);

    await pumpNarrow(tester, BlocProvider.value(value: cubit, child: const LanguagePage()));

    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Portuguese (Brazil)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
