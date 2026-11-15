import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

Future<(SkeletonizerConfigData, ResolvedSkeletonizerConfigData)> _pumpSkeleton(
  WidgetTester tester,
  AppThemeVariant variant,
) async {
  late SkeletonizerConfigData installed;
  late ResolvedSkeletonizerConfigData resolved;

  await tester.pumpWidget(
    BaseApp(
      theme: AppTheme.light(variant),
      home: Skeletonizer(
        child: Builder(
          builder: (context) {
            installed = SkeletonizerConfig.of(context);
            resolved = Skeletonizer.of(context).config;

            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );

  return (installed, resolved);
}

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('takes the skeleton colours from the ${variant.name} theme tokens', (tester) async {
      final (installed, resolved) = await _pumpSkeleton(tester, variant);
      final colors = AppColors.forVariant(variant);
      final effect = resolved.effect as ShimmerEffect;

      expect(installed.brightness, Brightness.light);
      expect(resolved.containersColor, colors.accentSoft);
      expect(effect.colors, [colors.accentSoft, colors.bgSurface, colors.accentSoft]);
    });
  }

  testWidgets('keeps the light theme skeleton colours on a dark platform', (tester) async {
    final (lightInstalled, lightResolved) = await _pumpSkeleton(tester, AppThemeVariant.rose);

    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    final (darkInstalled, darkResolved) = await _pumpSkeleton(tester, AppThemeVariant.rose);
    const colors = AppColors.rose;

    expect(darkInstalled, lightInstalled);
    expect(darkResolved, lightResolved);
    expect(darkInstalled.brightness, Brightness.light);
    expect(darkResolved.containersColor, colors.accentSoft);
    expect((darkResolved.effect as ShimmerEffect).colors, [
      colors.accentSoft,
      colors.bgSurface,
      colors.accentSoft,
    ]);
  });
}
