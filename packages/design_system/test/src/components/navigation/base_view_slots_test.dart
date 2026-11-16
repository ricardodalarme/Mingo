import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('view stacks bar, notice, body and footer in order for ${variant.name}', (
      tester,
    ) async {
      setSurface(tester);
      await tester.pumpWidget(
        BaseApp(
          theme: AppTheme.light(variant),
          home: const BaseView(
            appBar: BaseAppBar(title: 'Bar'),
            notice: Text('Notice'),
            footer: Text('Footer'),
            body: Text('Body'),
          ),
        ),
      );

      final bar = tester.getTopLeft(find.text('Bar')).dy;
      final notice = tester.getTopLeft(find.text('Notice')).dy;
      final body = tester.getTopLeft(find.text('Body')).dy;
      final footer = tester.getTopLeft(find.text('Footer')).dy;
      expect(bar, lessThan(notice));
      expect(notice, lessThan(body));
      expect(body, lessThan(footer));
    });
  }

  testWidgets('footer sits 20 from the sides and 34 from the bottom edge', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      BaseApp(
        theme: AppTheme.light(AppThemeVariant.rose),
        home: const BaseView(
          appBar: null,
          footer: SizedBox(key: Key('footer'), height: 50, width: double.infinity),
          body: SizedBox.shrink(),
        ),
      ),
    );

    final rect = tester.getRect(find.byKey(const Key('footer')));
    expect(rect.left, 20);
    expect(rect.right, 390 - 20);
    expect(844 - rect.bottom, 34);
  });

  testWidgets('without slots only the app bar and body render', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      BaseApp(
        theme: AppTheme.light(AppThemeVariant.rose),
        home: const BaseView(appBar: null, body: Text('Only body')),
      ),
    );

    expect(find.text('Only body'), findsOneWidget);
  });
}
