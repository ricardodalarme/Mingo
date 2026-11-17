import 'package:app/features/ideas/data/models/idea.dart';
import 'package:app/features/ideas/data/repositories/ideas_repository.dart';
import 'package:app/features/ideas/presentation/detail/cubit/idea_detail_cubit.dart';
import 'package:app/features/ideas/presentation/detail/widgets/idea_content.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/reminders/data/services/reminder_sync_service.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockIdeas() extends Mock implements IdeasRepository;

class _MockProfile() extends Mock implements ProfileRepository;

class _MockReminders() extends Mock implements RemindersRepository;

class _MockSync() extends Mock implements ReminderSyncService;

class _MockNotifications() extends Mock implements NotificationsRepository;

void main() {
  late IdeasRepository ideas;
  late ProfileRepository profile;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    ideas = _MockIdeas();
    profile = _MockProfile();
    when(() => ideas.getIdeas(any())).thenAnswer(
      (_) async => const [
        Idea(slug: 'bilhete', title: 'Deixe um bilhete na mochila', body: 'Pequeno e grátis.'),
      ],
    );
    when(() => profile.getMySettings()).thenAnswer(
      (_) async => const AccountSettings(
        theme: AppThemeVariant.rose,
        phase: RelationshipPhase.livingTogether,
      ),
    );
    when(() => ideas.isDone(any())).thenReturn(false);
    when(() => ideas.markDone(any())).thenAnswer((_) async {});
  });

  Future<IdeaDetailCubit> pump(WidgetTester tester) async {
    final cubit = IdeaDetailCubit(
      ideasRepository: ideas,
      profileRepository: profile,
      remindersRepository: _MockReminders(),
      reminderSyncService: _MockSync(),
      notificationsRepository: _MockNotifications(),
    );
    addTearDown(cubit.close);
    await cubit.load('bilhete');

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const IdeaContent()));
    await tester.pump();

    return cubit;
  }

  testWidgets('the idea is a hero card with the reason and the actions', (tester) async {
    await pump(tester);

    expect(find.text('IDEIA DO DIA'), findsOneWidget);
    expect(find.textContaining('Deixe um', findRichText: true), findsOneWidget);
    expect(find.text('Pequeno e grátis.'), findsOneWidget);
    expect(find.text('Por que esta ideia'), findsOneWidget);
    expect(find.text('Sua fase'), findsOneWidget);
    expect(find.text('Eu vou fazer'), findsOneWidget);
    expect(find.text('Outra ideia'), findsOneWidget);
    expect(find.text('Mais tarde'), findsOneWidget);
    expect(find.byType(BaseSurfaceCard), findsOneWidget);
  });

  testWidgets('marking it done changes the primary action', (tester) async {
    final cubit = await pump(tester);

    await tester.tap(find.text('Eu vou fazer'));
    await tester.pump();
    await tester.pump();

    verify(() => ideas.markDone('bilhete')).called(1);
    expect(find.text('Anotado. Que bom!'), findsOneWidget);
    expect(cubit.state.isDone, isTrue);
  });
}
