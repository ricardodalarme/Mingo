import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

/// Diameters of a [BaseAvatar].
enum BaseAvatarSize(final double diameter) {
  small(24),
  medium(40),
  large(64),
  xl(104);

  /// Whether the outline is the wider 3 point ring.
  bool get hasWideRing => this == large || this == xl;

  double get initialSize => switch (this) {
    small => 11,
    medium => 15,
    large => 22,
    xl => 40,
  };
}

const double _ringWidth = 2;
const double _wideRingWidth = 3;
const double _maxInitialScale = 1.2;
const double _badgeSide = 34;
const double _uploadingOpacity = .6;

/// A round avatar: photo, initials or an empty slot.
///
/// When [onTap] is supplied the target is 44pt. On [BaseAvatarSize.xl] supplying [onEdit] adds the
/// edit badge, which belongs to the avatar and opens the same action: the whole circle is the target.
class const BaseAvatar({
  final String? initials,
  final String? imageUrl,
  final BaseAvatarSize size = .medium,
  final bool isPartner = false,
  final bool isEmpty = false,
  final bool hasRing = true,
  final VoidCallback? onTap,
  final VoidCallback? onEdit,
  final bool isUploading = false,
  final bool hasFailed = false,
  final String? semanticLabel,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final action = onEdit ?? onTap;
    final circle = isEmpty ? _empty(context) : _filled(context);
    final avatar = onEdit != null ? _withBadge(context, circle) : circle;
    final label =
        semanticLabel ??
        (onEdit != null ? context.designSystemL10nOrBase.identity.editPhoto : null);

    if (action != null) {
      return AppPressable(
        onTap: isUploading ? null : action,
        borderRadius: BorderRadius.circular(size.diameter / 2),
        semanticLabel: label,
        enforceMinTapTarget: true,
        child: label == null ? avatar : ExcludeSemantics(child: avatar),
      );
    }
    if (label == null) return avatar;

    return Semantics(label: label, image: true, child: avatar);
  }

  Widget _empty(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      width: size.diameter,
      height: size.diameter,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: DashedRoundedPainter(color: AppPalette.neutral300, radius: size.diameter / 2),
          ),
          Center(
            child: AppIcon(
              icon: AppIcons.plus,
              size: size == .xl ? AppIconSize.xl : AppIconSize.sm,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filled(BuildContext context) {
    final colors = context.colors;
    final isGradient = size == .xl && !isPartner;
    final style = context.text.titleXs.copyWith(
      fontSize: size.initialSize,
      fontWeight: FontWeight.w600,
      height: 1,
      color: isGradient
          ? colors.textOnAction
          : (isPartner ? AppPalette.partnerAvatarInk : colors.accentLabel),
    );
    Widget initial = Text(
      initials ?? '',
      maxLines: 1,
      overflow: TextOverflow.clip,
      textAlign: TextAlign.center,
      style: style,
    );
    if (MediaQuery.maybeOf(context) != null) {
      initial = MediaQuery.withClampedTextScaling(maxScaleFactor: _maxInitialScale, child: initial);
    }

    return Container(
      width: size.diameter,
      height: size.diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isPartner ? AppPalette.partnerAvatarSurface : colors.accentSoft,
        gradient: isGradient
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppPalette.avatarWarm, colors.accentHighlight],
              )
            : null,
        shape: BoxShape.circle,
        boxShadow: hasRing
            ? [
                BoxShadow(
                  color: colors.bgScreen,
                  spreadRadius: size.hasWideRing ? _wideRingWidth : _ringWidth,
                ),
              ]
            : null,
      ),
      child: ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(child: initial),
            if (imageUrl != null)
              Opacity(
                opacity: isUploading ? _uploadingOpacity : 1,
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              ),
            if (isUploading)
              Center(
                child: ExcludeSemantics(child: BaseLoadingDots(color: colors.textOnAction)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _withBadge(BuildContext context, Widget circle) {
    final colors = context.colors;

    return SizedBox(
      width: size.diameter,
      height: size.diameter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          circle,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: _badgeSide,
              height: _badgeSide,
              decoration: BoxDecoration(
                color: colors.actionPrimary,
                shape: BoxShape.circle,
                border: Border.all(color: colors.bgScreen, width: _wideRingWidth),
              ),
              child: Center(
                child: AppIcon(
                  icon: hasFailed ? AppIcons.refresh : AppIcons.pencil,
                  color: colors.textOnAction,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
