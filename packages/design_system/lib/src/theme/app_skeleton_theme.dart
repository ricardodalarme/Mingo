import 'package:design_system/src/theme/app_theme.dart';
import 'package:design_system/src/tokens/tokens.dart';
import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart' show Theme;
import 'package:skeletonizer/skeletonizer.dart';

/// Skeleton colours taken from the theme instead of the platform brightness.
abstract final class AppSkeleton() {
  // One cached config per theme keeps `SkeletonizerConfig` from notifying every
  // descendant skeleton on each rebuild.
  static final Map<(AppColors, Brightness), SkeletonizerConfigData> _configs = {};

  /// The skeleton configuration for [colors] at the theme's [brightness].
  static SkeletonizerConfigData configOf(AppColors colors, Brightness brightness) =>
      _configs.putIfAbsent(
        (colors, brightness),
        () => SkeletonizerConfigData(
          brightness: brightness,
          containersColor: colors.bgSkeleton,
          effectResolver: (_) => ShimmerEffect(
            baseColor: colors.bgSkeleton,
            highlightColor: colors.bgSkeletonHighlight,
          ),
        ),
      );
}

/// Applies [AppSkeleton] to every [Skeletonizer] below it.
class const AppSkeletonTheme({required final Widget child, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SkeletonizerConfig(
      data: AppSkeleton.configOf(theme.colors, theme.brightness),
      child: child,
    );
  }
}
