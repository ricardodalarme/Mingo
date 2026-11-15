import 'dart:async';

import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestRouter() extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: NotFoundRoute.page, initial: true),
    AutoRoute(page: TimeInAppRoute.page, fullscreenDialog: true),
  ];
}

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  Future<void> pumpPage(WidgetTester tester, RootStackRouter router) {
    return tester.pumpWidget(
      TranslationProvider(
        child: AppThemeHost(
          initialVariant: AppThemeVariant.rose,
          child: Builder(
            builder: (context) => BaseApp.router(
              routerConfig: router.config(),
              theme: AppTheme.light(AppThemeScope.of(context)),
              supportedLocales: AppLocaleUtils.supportedLocales,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openPage(WidgetTester tester, RootStackRouter router) async {
    await pumpPage(tester, router);
    unawaited(router.push(const TimeInAppRoute()));
    await tester.pumpAndSettle();
  }

  testWidgets('cancel closes the page', (tester) async {
    final router = _TestRouter();
    await openPage(tester, router);

    expect(find.text('Cancelar'), findsOneWidget);

    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(router.stack.map((route) => route.name), isNot(contains(TimeInAppRoute.name)));
  });
}
