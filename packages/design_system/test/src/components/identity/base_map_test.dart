import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('map frame renders markers and attribution for ${variant.name}', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        galleryHost(
          BaseMap(
            semanticLabel: 'Two places, 12 km apart',
            attribution: 'Map data',
            markers: [
              const BaseMapMarker.pin(position: Alignment(.5, -.2)),
              BaseMapMarker.person(position: const Alignment(-.5, .3), initials: 'R'),
            ],
            route: const [Alignment(-.5, .3), Alignment(.5, -.2)],
          ),
          variant: variant,
        ),
      );

      expect(tester.getSize(find.byType(BaseMap)).height, 220);
      expect(find.text('Map data'), findsOneWidget);
      expect(find.bySemanticsLabel('Two places, 12 km apart'), findsOneWidget);
      semantics.dispose();
    });
  }

  testWidgets('offline says the map needs a connection', (tester) async {
    await tester.pumpWidget(
      galleryHost(const BaseMap(status: .offline), variant: AppThemeVariant.rose),
    );

    expect(find.text('The map needs a connection'), findsOneWidget);
  });

  testWidgets('denied location offers the permission action', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      galleryHost(
        BaseMap(status: .locationDenied, onAllowLocation: () => taps++),
        variant: AppThemeVariant.rose,
      ),
    );

    await tester.tap(find.text('Allow location'));
    expect(taps, 1);
  });

  testWidgets('a preview map reports taps', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      galleryHost(BaseMap(onTap: () => taps++), variant: AppThemeVariant.rose),
    );

    await tester.tap(find.byType(BaseMap));
    expect(taps, 1);
  });
}
