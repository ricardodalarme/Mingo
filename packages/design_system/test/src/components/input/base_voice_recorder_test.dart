import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

Widget _recorder(
  BaseVoiceStatus status, {
  Duration elapsed = Duration.zero,
  String? errorText,
  List<String>? log,
}) {
  return BaseVoiceRecorder(
    status: status,
    elapsed: elapsed,
    maxDuration: const Duration(seconds: 30),
    levels: const [.2, .8, .5],
    errorText: errorText,
    onRecord: () => log?.add('record'),
    onStop: () => log?.add('stop'),
    onCancel: () => log?.add('cancel'),
    onSend: () => log?.add('send'),
    onRerecord: () => log?.add('rerecord'),
  );
}

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('idle shows 00:00 with Cancel and Record for ${variant.name}', (tester) async {
      final log = <String>[];
      await tester.pumpWidget(galleryHost(_recorder(.idle, log: log), variant: variant));

      expect(find.text('00:00'), findsOneWidget);
      await tester.tap(find.text('Record'));
      await tester.tap(find.text('Cancel'));
      expect(log, ['record', 'cancel']);
    });
  }

  testWidgets('recording counts the timer and offers Stop', (tester) async {
    final log = <String>[];
    await tester.pumpWidget(
      galleryHost(
        _recorder(.recording, elapsed: const Duration(seconds: 12), log: log),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.text('00:12'), findsOneWidget);
    await tester.tap(find.text('Stop'));
    expect(log, ['stop']);
  });

  testWidgets('recorded swaps to Re-record and Send, and nothing sends by itself', (tester) async {
    final log = <String>[];
    await tester.pumpWidget(
      galleryHost(
        _recorder(.recorded, elapsed: const Duration(seconds: 9), log: log),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(log, isEmpty);
    await tester.tap(find.text('Record again'));
    await tester.tap(find.text('Send'));
    expect(log, ['rerecord', 'send']);
  });

  testWidgets('uploading shows dots and error shows the message', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        _recorder(.uploading, elapsed: const Duration(seconds: 9)),
        variant: AppThemeVariant.rose,
      ),
    );
    expect(find.byType(BaseLoadingDots), findsOneWidget);

    await tester.pumpWidget(
      galleryHost(
        _recorder(.failed, elapsed: const Duration(seconds: 9), errorText: 'Could not send'),
        variant: AppThemeVariant.rose,
      ),
    );
    expect(find.text('Could not send'), findsOneWidget);
  });

  testWidgets('player toggles, shows the duration and exposes a position slider', (tester) async {
    final semantics = tester.ensureSemantics();
    var toggles = 0;
    final seeks = <double>[];
    await tester.pumpWidget(
      galleryHost(
        BaseVoicePlayer(
          duration: const Duration(seconds: 12),
          isPlaying: false,
          progress: .5,
          onToggle: () => toggles++,
          onSeek: seeks.add,
        ),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.text('0:12'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Play')), findsOneWidget);
    await tester.tap(find.byIcon(AppIcons.play));
    expect(toggles, 1);
    final slider = find.byWidgetPredicate(
      (widget) => widget is Semantics && (widget.properties.slider ?? false),
    );
    expect(tester.getSemantics(slider).value, '50%');
    semantics.dispose();
  });
}
