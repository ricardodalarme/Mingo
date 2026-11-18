import 'package:design_system/design_system.dart';

/// The filled heart the home widgets draw, which the outlined icon font does not offer.
class const HomeWidgetHeart({required final double size, required final Color color, super.key})
    extends StatelessWidget {
  static const String _path =
      'M12 20.5C5 15.5 3 12 3 8.8 3 6.2 5 4.5 7.3 4.5c1.9 0 3.5 1 4.7 2.9 1.2-1.9 2.8-2.9 4.7-2.9C19 4.5 21 6.2 21 8.8c0 3.2-2 6.7-9 11.7z';

  @override
  Widget build(BuildContext context) {
    final hex = (color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0');

    return SvgPicture.string(
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="#$hex" d="$_path"/></svg>',
      width: size,
      height: size,
    );
  }
}
