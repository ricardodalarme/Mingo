import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:design_system/design_system.dart';

/// The size a home widget is laid out at before it scales to the space it is given.
extension HomeWidgetSizeCanvas on HomeWidgetSize {
  double get canvasWidth => switch (this) {
    .small => 169,
    .medium => 358,
  };

  double get canvasHeight => 169;
}

/// The rounded surface every home widget preview sits on, laid out at the native size.
///
/// Previews are not interactive: the real home widget is what the person taps.
class const HomeWidgetFrame({
  required final HomeWidgetSize size,
  required final Widget child,
  final Decoration? decoration,
  final EdgeInsetsGeometry padding = EdgeInsets.zero,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: size.canvasWidth / size.canvasHeight,
      child: FittedBox(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: SizedBox(
            width: size.canvasWidth,
            height: size.canvasHeight,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.card)),
                boxShadow: AppShadows.ring,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(AppRadius.card)),
                child: DecoratedBox(
                  decoration: decoration ?? const BoxDecoration(),
                  child: Padding(padding: padding, child: child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
