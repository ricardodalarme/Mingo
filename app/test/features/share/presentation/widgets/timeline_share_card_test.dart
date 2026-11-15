import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/timeline_share_card.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  final entries = [
    ShareTimelineEntry(title: 'Primeiro jantar', date: DateTime(2026, 5, 12), place: 'Paraty'),
    ShareTimelineEntry(title: 'Nosso primeiro show', date: DateTime(2026, 2, 3)),
    ShareTimelineEntry(title: 'A viagem da praia', date: DateTime(2025, 12, 28), place: 'Ubatuba'),
  ];

  testWidgets('shows each real moment with its date and place', (tester) async {
    await tester.pumpApp(Center(child: TimelineShareCard(entries: entries)));

    expect(find.text('NOSSA LINHA DO TEMPO'), findsOneWidget);
    expect(find.text('Momentos que a gente guardou'), findsOneWidget);

    expect(find.text('Primeiro jantar'), findsOneWidget);
    expect(find.text('12 de maio de 2026 · Paraty'), findsOneWidget);

    expect(find.text('Nosso primeiro show'), findsOneWidget);
    expect(find.text('3 de fevereiro de 2026'), findsOneWidget);

    expect(find.text('A viagem da praia'), findsOneWidget);
    expect(find.text('28 de dezembro de 2025 · Ubatuba'), findsOneWidget);
  });

  testWidgets('long titles wrap inside the card without overflowing it', (tester) async {
    await tester.pumpApp(
      Center(
        child: TimelineShareCard(
          entries: [
            ShareTimelineEntry(
              title: 'O dia em que a gente se perdeu na estrada e riu até o sol nascer',
              date: DateTime(2026, 5, 12),
              place: 'Serra do Mar',
            ),
            ShareTimelineEntry(
              title: 'A primeira vez que cozinhamos juntos para a família toda',
              date: DateTime(2026, 2, 3),
              place: 'Casa da mãe',
            ),
            ShareTimelineEntry(
              title: 'O show que a gente quase não foi e virou nossa música',
              date: DateTime(2025, 12, 28),
            ),
          ],
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Serra do Mar'), findsOneWidget);
  });
}
