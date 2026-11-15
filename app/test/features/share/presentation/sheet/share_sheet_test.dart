import 'dart:typed_data';

import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/data/repositories/share_image_repository.dart';
import 'package:app/features/share/presentation/sheet/share_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockShareImageRepository() extends Mock implements ShareImageRepository;

const _pngSignature = [0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a];

/// Gives the engine real time to render the PNG, then pumps the result into the tree.
Future<void> _waitUntil(WidgetTester tester, bool Function() isDone) async {
  for (var attempt = 0; attempt < 100 && !isDone(); attempt++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
    await tester.pump();
  }
}

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(Uint8List(0));
  });

  late ShareImageRepository repository;

  setUp(() {
    repository = _MockShareImageRepository();
    AppInjector.instance.registerSingleton<ShareImageRepository>(repository);
  });

  tearDown(() => AppInjector.instance.unregister<ShareImageRepository>());

  testWidgets('sharing captures a PNG and hands it to the share service', (tester) async {
    Uint8List? shared;
    when(() => repository.share(any())).thenAnswer((invocation) async {
      shared = invocation.positionalArguments.first as Uint8List;
    });

    await tester.pumpApp(ShareSheet(cards: [ShareCounterCard(since: DateTime(2024, 3, 14))]));
    await tester.pump();

    await tester.tap(find.text('Compartilhar'));
    await _waitUntil(tester, () => shared != null);

    expect(shared, isNotNull);
    expect(shared!.sublist(0, _pngSignature.length), _pngSignature);
    expect(find.text('Compartilhar'), findsOneWidget);
  });

  testWidgets('two cards are switched by the segmented control', (tester) async {
    when(() => repository.share(any())).thenAnswer((_) async {});

    await tester.pumpApp(
      ShareSheet(
        cards: [
          ShareCounterCard(since: DateTime(2024, 3, 14)),
          ShareMoonCard(date: DateTime.utc(2024, 4, 23, 23, 49)),
        ],
      ),
    );
    await tester.pump();

    expect(find.text('Nosso tempo'), findsOneWidget);
    expect(find.text('Lua cheia'), findsNothing);

    await tester.tap(find.text('A lua do nosso dia'));
    await tester.pump();

    expect(find.text('Lua cheia'), findsOneWidget);
  });

  testWidgets('a failed share says so without closing the sheet', (tester) async {
    when(() => repository.share(any())).thenThrow(Exception('no share sheet'));
    const message = 'Não deu para compartilhar agora. Tente de novo.';

    await tester.pumpApp(ShareSheet(cards: [ShareCounterCard(since: DateTime(2024, 3, 14))]));
    await tester.pump();

    await tester.tap(find.text('Compartilhar'));
    await _waitUntil(tester, () => find.text(message).evaluate().isNotEmpty);

    expect(find.text(message), findsOneWidget);
    expect(find.text('Compartilhar'), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pump();
  });
}
