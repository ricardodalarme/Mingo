import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/data/repositories/share_image_repository.dart';
import 'package:app/features/share/presentation/widgets/share_image_entry.dart';
import 'package:app/features/share/presentation/widgets/share_image_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockShareImageRepository() extends Mock implements ShareImageRepository;

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('stays hidden when there is nothing to share', (tester) async {
    await tester.pumpApp(const ShareImageEntry(cards: [], subtitle: 'Sem imagem ainda'));

    expect(find.byType(BaseListGroup), findsNothing);
    expect(find.text('Compartilhar imagem'), findsNothing);
  });

  testWidgets('offers the entry with the subtitle of the screen it is on', (tester) async {
    await tester.pumpApp(
      ShareImageEntry(
        cards: [ShareCounterCard(since: DateTime(2024, 3, 14))],
        subtitle: 'O tempo de vocês e a lua do dia em que tudo começou.',
      ),
    );

    expect(find.text('Compartilhar imagem'), findsOneWidget);
    expect(find.text('O tempo de vocês e a lua do dia em que tudo começou.'), findsOneWidget);
    expect(find.byIcon(AppIcons.share), findsOneWidget);
  });

  testWidgets('opens the sheet with the preview and the share action', (tester) async {
    AppInjector.instance.registerSingleton<ShareImageRepository>(_MockShareImageRepository());
    addTearDown(() => AppInjector.instance.unregister<ShareImageRepository>());

    await tester.pumpApp(
      ShareImageEntry(
        cards: [ShareCounterCard(since: DateTime(2024, 3, 14))],
        subtitle: 'O tempo de vocês',
      ),
    );

    await tester.tap(find.text('Compartilhar imagem'));
    await tester.pumpAndSettle();

    expect(
      find.text('A imagem é feita no seu aparelho e só sai daqui quando você compartilhar.'),
      findsOneWidget,
    );
    expect(find.byType(ShareImagePreview), findsOneWidget);
    expect(find.text('Compartilhar'), findsOneWidget);
  });
}
