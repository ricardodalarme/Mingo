import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_mood_hint.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

void main() {
  final day = DateTime(2026, 11, 10);
  PartnerMood mood(MoodKind value) => PartnerMood(day: day, mood: value);

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  Future<void> pumpHint(
    WidgetTester tester, {
    required MoodKind value,
    VoidCallback? onReact,
    bool isDiscreet = false,
  }) async {
    await tester.pumpApp(
      PartnerMoodHint(
        partnerMood: mood(value),
        partnerName: 'Marina',
        isDiscreet: isDiscreet,
        onReact: onReact,
      ),
    );
    await tester.pump();
  }

  double top(WidgetTester tester, String text) => tester.getTopLeft(find.text(text)).dy;

  void expectNoBadDay() {
    expect(find.text('Um dia difícil'), findsNothing);
    expect(
      find.text('Três coisas pequenas que podem ajudar agora. Nada obrigatório.'),
      findsNothing,
    );
  }

  testWidgets('discreet mode shows no partner, mood or note wording', (tester) async {
    await pumpHint(tester, value: MoodKind.tired, isDiscreet: true);

    expect(find.textContaining('Marina'), findsNothing);
    expect(find.textContaining('energia'), findsNothing);
    expect(find.textContaining('Humor'), findsNothing);
  });

  for (final value in [MoodKind.happy, MoodKind.loving, MoodKind.playful]) {
    testWidgets('a ${value.name} mood opens no screen and offers a heart', (tester) async {
      var reactions = 0;
      await pumpHint(tester, value: value, onReact: () => reactions++);

      await tester.tap(find.textContaining('Marina está'));
      await tester.pumpAndSettle();

      expect(find.text('Escuta primeiro'), findsNothing);
      expect(find.text('Como ajudar hoje'), findsNothing);
      expectNoBadDay();

      await tester.tap(find.byIcon(AppIcons.heart_filled));
      await tester.pump();

      expect(reactions, 1);
    });
  }

  testWidgets('a tired partner opens how to help with the chore first', (tester) async {
    await pumpHint(tester, value: MoodKind.tired);

    await tester.tap(find.textContaining('sem energia'));
    await tester.pumpAndSettle();

    expect(find.text('Como ajudar hoje'), findsOneWidget);
    expect(
      top(tester, 'Assumir uma tarefa'),
      lessThan(top(tester, 'Perguntar: quer ouvir ou espaço?')),
    );
    expectNoBadDay();
  });

  testWidgets('a stressed partner opens how to help with the question first', (tester) async {
    await pumpHint(tester, value: MoodKind.stressed);

    await tester.tap(find.textContaining('cabeça cheia'));
    await tester.pumpAndSettle();

    expect(find.text('Como ajudar hoje'), findsOneWidget);
    expect(
      top(tester, 'Perguntar: quer ouvir ou espaço?'),
      lessThan(top(tester, 'Assumir uma tarefa')),
    );
    expectNoBadDay();
  });

  testWidgets('a sad partner listens first and can open how to help', (tester) async {
    await pumpHint(tester, value: MoodKind.sad);

    await tester.tap(find.textContaining('para baixo'));
    await tester.pumpAndSettle();

    expect(find.text('Escuta primeiro'), findsOneWidget);
    expect(top(tester, 'Perguntar se quer conversar'), lessThan(top(tester, 'Mandar um carinho')));
    expect(top(tester, 'Mandar um carinho'), lessThan(top(tester, 'Ver como ajudar')));
    expectNoBadDay();

    await tester.tap(find.text('Ver como ajudar'));
    await tester.pumpAndSettle();

    expect(find.text('Como ajudar hoje'), findsOneWidget);
    expectNoBadDay();
  });

  testWidgets('a sad partner can send love from the sheet', (tester) async {
    var reactions = 0;
    await pumpHint(tester, value: MoodKind.sad, onReact: () => reactions++);

    await tester.tap(find.textContaining('para baixo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mandar um carinho'));
    await tester.pumpAndSettle();

    expect(reactions, 1);
  });
}
