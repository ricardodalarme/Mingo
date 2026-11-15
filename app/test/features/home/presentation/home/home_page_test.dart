import 'package:app/features/home/presentation/home/home_page.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

class const _TabFrame({required final Animation<double> animation}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      homeTabTransition(context, const Text('tab body'), animation);
}

Widget _tabHost({required Animation<double> animation, bool reduceMotion = false}) {
  return BaseApp(
    theme: AppTheme.light(AppThemeVariant.rose),
    home: Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
        child: _TabFrame(animation: animation),
      ),
    ),
  );
}

Finder _inFrame(Type type) =>
    find.descendant(of: find.byType(_TabFrame), matching: find.byType(type));

void main() {
  test('the shell tabs use the board icons, with capture in the middle', () {
    expect(homeTabIcons, [
      AppIcons.home,
      AppIcons.note,
      AppIcons.plus,
      AppIcons.rings,
      AppIcons.bookmark,
    ]);
  });

  test('slips, together and memories no longer share generic glyphs', () {
    expect(homeTabIcons, isNot(contains(AppIcons.heart)));
    expect(homeTabIcons, isNot(contains(AppIcons.users)));
    expect(homeTabIcons, isNot(contains(AppIcons.book)));
  });

  testWidgets('the incoming tab fades in and lifts into place', (tester) async {
    await tester.pumpWidget(_tabHost(animation: const AlwaysStoppedAnimation(.5)));

    expect(tester.widget<FadeTransition>(_inFrame(FadeTransition)).opacity.value, .5);
    expect(
      tester.widget<SlideTransition>(_inFrame(SlideTransition)).position.value.dy,
      closeTo(.006, .0001),
    );
    expect(find.text('tab body'), findsOneWidget);
  });

  testWidgets('reduced motion swaps the tab with no movement', (tester) async {
    await tester.pumpWidget(
      _tabHost(animation: const AlwaysStoppedAnimation(.5), reduceMotion: true),
    );

    expect(_inFrame(FadeTransition), findsNothing);
    expect(_inFrame(SlideTransition), findsNothing);
    expect(find.text('tab body'), findsOneWidget);
  });
}
