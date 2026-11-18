import 'package:design_system/design_system.dart';

/// The colors a home-screen widget paints with, mirroring the native extensions.
///
/// Home-screen widgets sit outside the app theme, so their colors live here as one named set
/// per theme variant instead of coming from `context.colors`.
final class const HomeWidgetPalette({
  required final Color soft,
  required final Color highlight,
  required final Color label,
  required final Color border,
  required final Color tintStart,
  required final Color tintEnd,
  required final Color mist,
  required final Color ink,
}) {
  factory of(AppThemeVariant theme) => switch (theme) {
    .rose => rose,
    .blue => blue,
    .neutral => neutral,
  };

  static const HomeWidgetPalette rose = HomeWidgetPalette(
    soft: AppHue.roseSoft,
    highlight: AppHue.roseHighlight,
    label: AppHue.roseLabel,
    border: AppHue.roseBorder,
    tintStart: Color(0xFFFFD3DE),
    tintEnd: Color(0xFFFFB9A6),
    mist: Color(0xFFFFD6E0),
    ink: Color(0xFF6E2C3C),
  );

  static const HomeWidgetPalette blue = HomeWidgetPalette(
    soft: AppHue.blueSoft,
    highlight: AppHue.blueHighlight,
    label: AppHue.blueLabel,
    border: AppHue.blueBorder,
    tintStart: Color(0xFFCFE2FA),
    tintEnd: Color(0xFFA9C8F2),
    mist: Color(0xFFD4E5FB),
    ink: Color(0xFF1F3F66),
  );

  static const HomeWidgetPalette neutral = HomeWidgetPalette(
    soft: AppHue.neutralSoft,
    highlight: AppHue.neutralHighlight,
    label: AppHue.neutralLabel,
    border: AppHue.neutralBorder,
    tintStart: Color(0xFFD6ECDE),
    tintEnd: Color(0xFFB7DCC6),
    mist: Color(0xFFD9EEE0),
    ink: Color(0xFF24473A),
  );

  /// The warm second stop of the date gradients.
  static const Color peach = Color(0xFFFFE3C4);

  /// The deep charcoal of the second avatar and the slip card.
  static const Color charcoal = Color(0xFF2B2828);

  /// The plum the slip card fades to.
  static const Color plum = Color(0xFF5A2C40);

  /// The paper of a partner note and the ink written on it.
  static const Color paper = Color(0xFFFFF3D2);
  static const Color paperInk = Color(0xFF5B3A1E);
  static const Color paperLine = Color(0x2EB48C3C);

  /// The night sky of the ritual home widget.
  static const Color nightStart = Color(0xFF2D2F57);
  static const Color nightMiddle = Color(0xFF6A5389);
  static const Color nightEnd = Color(0xFFB88AA8);

  /// The two halves of the distance home widget.
  static const Color dayStart = Color(0xFFFFB66B);
  static const Color dayEnd = Color(0xFFFF7E6B);
  static const Color nightHalfEnd = Color(0xFF5B4B88);

  /// The warm cream of the idea home widget.
  static const Color cream = Color(0xFFFFF1E3);

  /// The light blue of the next-date home widget.
  static const Color sky = Color(0xFFE8F1FF);
  static const Color skyInk = Color(0xFF2B2D4E);
  static const Color confettiYellow = Color(0xFFFFC25C);
  static const Color confettiBlue = Color(0xFF7FB8F0);
}
