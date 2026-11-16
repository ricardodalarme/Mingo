import 'package:design_system/design_system.dart';

const double _overlap = 8;
const double _largeOverlap = 12;

/// Two overlapping avatars.
///
/// Without a partner the second slot is empty; [onTap] makes the pair actionable.
class const BaseAvatarPair({
  final String? selfInitials,
  final String? partnerInitials,
  final String? selfImageUrl,
  final String? partnerImageUrl,
  final BaseAvatarSize size = .medium,
  final VoidCallback? onTap,
  final String? semanticLabel,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diameter = size.diameter;
    final overlap = size.hasWideRing ? _largeOverlap : _overlap;
    final hasPartner = partnerInitials != null || partnerImageUrl != null;

    final pair = SizedBox(
      width: diameter * 2 - overlap,
      height: diameter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: BaseAvatar(
              initials: selfInitials,
              imageUrl: selfImageUrl,
              size: size,
              isEmpty: selfInitials == null && selfImageUrl == null,
            ),
          ),
          Positioned(
            left: diameter - overlap,
            child: BaseAvatar(
              initials: partnerInitials,
              imageUrl: partnerImageUrl,
              size: size,
              isPartner: true,
              isEmpty: !hasPartner,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return AppPressable(
        onTap: onTap,
        borderRadius: BorderRadius.circular(diameter),
        semanticLabel: semanticLabel,
        enforceMinTapTarget: true,
        child: pair,
      );
    }
    if (semanticLabel == null) return pair;

    return Semantics(label: semanticLabel, image: true, child: pair);
  }
}
