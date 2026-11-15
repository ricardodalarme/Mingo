import 'package:common_ui/common_ui.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child, {bool reduceMotion = false}) {
  return BaseApp(
    theme: AppTheme.light(AppThemeVariant.rose),
    home: reduceMotion
        ? Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context).copyWith(disableAnimations: true),
              child: child,
            ),
          )
        : child,
  );
}

Widget _rows({bool play = true}) {
  return RevealScope(
    play: play,
    child: Column(
      children: [
        for (var index = 0; index < 3; index++)
          Reveal(
            index: index,
            child: SizedBox(height: 40, child: Text('row $index')),
          ),
      ],
    ),
  );
}

double _opacityOf(WidgetTester tester, int index) {
  final opacity = tester.widget<Opacity>(
    find.descendant(of: find.byType(Reveal).at(index), matching: find.byType(Opacity)).first,
  );

  return opacity.opacity;
}

double _dyOf(WidgetTester tester, int index) {
  final transform = tester.widget<Transform>(
    find.descendant(of: find.byType(Reveal).at(index), matching: find.byType(Transform)).first,
  );

  return transform.transform.getTranslation().y;
}

void main() {
  group('RevealScope', () {
    testWidgets('rows arrive in order and settle at rest', (tester) async {
      await tester.pumpWidget(_host(_rows()));

      expect(_opacityOf(tester, 0), 0);
      expect(_opacityOf(tester, 1), 0);
      expect(_opacityOf(tester, 2), 0);
      expect(_dyOf(tester, 0), AppSpace.s8);

      await tester.pump(AppMotion.stagger);

      expect(_opacityOf(tester, 0), greaterThan(.5));
      expect(_opacityOf(tester, 1), lessThan(.01));
      expect(_opacityOf(tester, 2), lessThan(.01));

      await tester.pump(AppMotion.stagger);

      expect(_opacityOf(tester, 0), 1);
      expect(_opacityOf(tester, 1), greaterThan(.5));
      expect(_opacityOf(tester, 2), lessThan(.01));

      await tester.pump(AppMotion.stagger);
      await tester.pump(AppMotion.fast);

      expect(_opacityOf(tester, 0), 1);
      expect(_opacityOf(tester, 1), 1);
      expect(_opacityOf(tester, 2), 1);
      expect(_dyOf(tester, 2), 0);
    });

    testWidgets('keeps the rows at rest until the data arrives', (tester) async {
      await tester.pumpWidget(_host(_rows(play: false)));

      expect(_opacityOf(tester, 0), 1);
      expect(_opacityOf(tester, 1), 1);

      await tester.pumpWidget(_host(_rows()));

      expect(_opacityOf(tester, 0), 0);

      await tester.pump(AppMotion.stagger);
      await tester.pump(AppMotion.stagger);
      await tester.pump(AppMotion.fast);

      expect(_opacityOf(tester, 2), 1);
    });

    testWidgets('does not replay when the rows rebuild or reload', (tester) async {
      await tester.pumpWidget(_host(_rows()));
      await tester.pump(AppMotion.stagger);
      await tester.pump(AppMotion.stagger);
      await tester.pump(AppMotion.fast);

      await tester.pumpWidget(_host(_rows()));

      expect(_opacityOf(tester, 0), 1);
      expect(_opacityOf(tester, 2), 1);

      await tester.pumpWidget(_host(_rows(play: false)));
      await tester.pumpWidget(_host(_rows()));

      expect(_opacityOf(tester, 0), 1);
      expect(_opacityOf(tester, 2), 1);
    });

    testWidgets('leaves a row tappable while it is still arriving', (tester) async {
      var taps = 0;

      await tester.pumpWidget(
        _host(
          RevealScope(
            child: Reveal(
              child: GestureDetector(
                onTap: () => taps++,
                child: const SizedBox(height: 40, width: 120, child: Text('row')),
              ),
            ),
          ),
        ),
      );

      expect(_opacityOf(tester, 0), 0);

      await tester.tap(find.text('row'));

      expect(taps, 1);
    });

    testWidgets('shows the rows at rest when the platform asks for reduced motion', (tester) async {
      await tester.pumpWidget(_host(_rows(), reduceMotion: true));

      expect(_opacityOf(tester, 0), 1);
      expect(_opacityOf(tester, 1), 1);
      expect(_opacityOf(tester, 2), 1);
      expect(_dyOf(tester, 2), 0);
    });
  });

  group('Reveal', () {
    testWidgets('plays its own entrance when no scope is above it', (tester) async {
      await tester.pumpWidget(_host(const Reveal(child: Text('card'))));

      expect(_opacityOf(tester, 0), 0);

      await tester.pump(AppMotion.base);

      expect(_opacityOf(tester, 0), 1);
      expect(_dyOf(tester, 0), 0);
    });

    testWidgets('arrives at rest under reduced motion', (tester) async {
      await tester.pumpWidget(_host(const Reveal(child: Text('card')), reduceMotion: true));

      expect(_opacityOf(tester, 0), 1);
    });
  });
}
