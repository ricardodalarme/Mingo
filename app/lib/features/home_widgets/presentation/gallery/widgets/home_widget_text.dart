import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:design_system/design_system.dart';

/// The small uppercase label at the top of a home widget.
class const HomeWidgetEyebrow({required final String text, final Color? color, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.text.micro.copyWith(
        color: color ?? DefaultTextStyle.of(context).style.color,
        fontSize: 11.5,
        letterSpacing: 0.7,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

/// A line of home widget text at an exact size.
class const HomeWidgetText({
  required final String text,
  required final double size,
  final FontWeight weight = FontWeight.w400,
  final Color? color,
  final double? height,
  final double? letterSpacing,
  final int maxLines = 2,
  final TextAlign? align,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      style: context.text.body.copyWith(
        color: color ?? DefaultTextStyle.of(context).style.color,
        fontSize: size,
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
      ),
    );
  }
}

/// A line of handwriting at an exact size.
class const HomeWidgetHandText({
  required final String text,
  required final double size,
  final Color? color,
  final int maxLines = 3,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: context.text.hand.copyWith(
        color: color ?? DefaultTextStyle.of(context).style.color,
        fontSize: size,
        height: 1.05,
      ),
    );
  }
}

/// Two overlapping initials circles for the two people.
class const HomeWidgetInitials({
  required final String? own,
  required final String? partner,
  required final Color ownColor,
  required final Color ownBackground,
  final double size = 26,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ownInitial = _initial(own);
    final partnerInitial = _initial(partner);
    if (ownInitial == null && partnerInitial == null) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (ownInitial != null) _Circle(ownInitial, ownColor, ownBackground, size),
        if (partnerInitial != null)
          Transform.translate(
            offset: Offset(ownInitial == null ? 0 : -size * 0.3, 0),
            child: _Circle(partnerInitial, AppPalette.white, HomeWidgetPalette.charcoal, size),
          ),
      ],
    );
  }

  String? _initial(String? name) {
    final trimmed = name?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;

    return trimmed.characters.first.toUpperCase();
  }
}

class const _Circle(
  final String initial,
  final Color color,
  final Color background,
  final double size,
) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: AppPalette.white, width: 2),
      ),
      child: Text(
        initial,
        style: context.text.micro.copyWith(color: color, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}
