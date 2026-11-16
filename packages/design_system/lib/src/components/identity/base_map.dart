import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

/// What a [BaseMap] shows.
enum BaseMapStatus() {
  /// The frame with its markers, over the placeholder or the supplied [BaseMap.child].
  ready,

  /// A skeleton the size of the frame.
  loading,

  /// A placeholder saying the map needs a connection.
  offline,

  /// A placeholder with the action that opens the permission sheet.
  locationDenied,
}

/// A marker placed at a fractional [position] of the map frame, from (-1, -1) to (1, 1).
class const BaseMapMarker({required final Alignment position, required final Widget child}) {
  /// A 36 point pin: a surface circle with an accent line pin.
  const new pin({required Alignment position})
    : this(position: position, child: const _PinMarker());

  /// A 28 point avatar with a 2 point white ring.
  new person({required Alignment position, required String initials, bool isPartner = false})
    : this(
        position: position,
        child: _PersonMarker(initials: initials, isPartner: isPartner),
      );
}

const double _pinSize = 36;
const double _personSize = 28;
const double _routeWidth = 2;

/// A framed map with marker slots and an attribution line.
///
/// The tile provider is not fixed: the frame, markers and states are. Without a [child] a painted
/// placeholder is shown. The map is one element with [semanticLabel] as its summary; markers are not
/// focusable. A tap on a preview map calls [onTap]; the feature supplies [attribution] and keeps it visible.
class const BaseMap({
  final double height = 220,
  final List<BaseMapMarker> markers = const [],
  final List<Alignment> route = const [],
  final BaseMapStatus status = .ready,
  final Widget? child,
  final String? attribution,
  final VoidCallback? onTap,
  final VoidCallback? onAllowLocation,
  final String? semanticLabel,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.designSystemL10nOrBase.identity;
    final radius = BorderRadius.circular(24);

    final body = switch (status) {
      .loading => const Skeleton.leaf(child: ColoredBox(color: AppPalette.neutral100)),
      .offline => _Notice(icon: AppIcons.wifi_off, text: l10n.mapOffline),
      .locationDenied => _Notice(
        icon: AppIcons.map_pin,
        text: l10n.mapLocationDenied,
        actionText: l10n.mapAllowLocation,
        onAction: onAllowLocation,
      ),
      .ready => Stack(
        fit: StackFit.expand,
        children: [
          child ??
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [colors.accentSoft, colors.bgSurface],
                  ),
                ),
              ),
          if (route.length > 1)
            CustomPaint(
              painter: _RoutePainter(points: route, color: colors.accentHighlight),
            ),
          for (final marker in markers) Align(alignment: marker.position, child: marker.child),
          if (attribution != null)
            Positioned(
              left: AppSpace.s12,
              bottom: AppSpace.s8,
              child: Text(
                attribution!,
                style: context.text.micro.copyWith(color: colors.textSecondary),
              ),
            ),
        ],
      ),
    };

    final frame = Container(
      height: height,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: radius,
        border: AppBorders.hair(colors.borderDefault),
      ),
      child: body,
    );

    return Semantics(
      container: true,
      label: semanticLabel,
      button: onTap != null,
      child: ExcludeSemantics(
        child: onTap == null
            ? frame
            : AppPressable(onTap: onTap, borderRadius: radius, scaleOnPress: false, child: frame),
      ),
    );
  }
}

class const _PinMarker() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: _pinSize,
      height: _pinSize,
      decoration: BoxDecoration(
        color: colors.bgSurface,
        shape: BoxShape.circle,
        border: AppBorders.hair(colors.borderDefault),
      ),
      child: Center(
        child: AppIcon(icon: AppIcons.map_pin, color: colors.accentLabel),
      ),
    );
  }
}

class const _PersonMarker({required final String initials, required final bool isPartner})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: _personSize + 4,
      height: _personSize + 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppPalette.white, width: 2),
      ),
      child: ClipOval(
        child: ColoredBox(
          color: isPartner ? AppPalette.partnerAvatarSurface : colors.accentSoft,
          child: Center(
            child: Text(
              initials,
              style: context.text.micro.copyWith(
                fontWeight: FontWeight.w600,
                color: isPartner ? AppPalette.partnerAvatarInk : colors.accentLabel,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class const _Notice({
  required final IconData icon,
  required final String text,
  final String? actionText,
  final VoidCallback? onAction,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ColoredBox(
      color: colors.accentSoft,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.s20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(icon: icon, color: colors.accentLabel),
              const SizedBox(height: AppSpace.s8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: context.text.caption.copyWith(color: colors.textSecondary),
              ),
              if (actionText != null) ...[
                const SizedBox(height: AppSpace.s12),
                BaseButton.compact(text: actionText!, onPressed: onAction),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class const _RoutePainter({required final List<Alignment> points, required final Color color})
    extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (var index = 0; index < points.length; index++) {
      final offset = points[index].alongSize(size);
      if (index == 0) {
        path.moveTo(offset.dx, offset.dy);
      } else {
        path.lineTo(offset.dx, offset.dy);
      }
    }
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _routeWidth
      ..strokeCap = StrokeCap.round;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 6), paint);
        distance += 11;
      }
    }
  }

  @override
  bool shouldRepaint(_RoutePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.points != points;
}
