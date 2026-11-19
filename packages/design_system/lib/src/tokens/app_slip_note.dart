import 'package:design_system/src/tokens/app_palette.dart';
import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart' show ThemeExtension;

/// The tint of a slip note.
enum SlipNoteType() {
  good,
  help,
  notice,
  said,
  annoyed,
}

/// How big a slip note is drawn.
enum SlipNoteSize() {
  wall,
  large,
}

/// The paper and ink colours of one [SlipNoteType].
final class const SlipNoteTone({required final Color background, required final Color ink});

/// Slip note colours; the pairs do not change with the app theme.
class const AppSlipNoteColors({
  required final SlipNoteTone good,
  required final SlipNoteTone help,
  required final SlipNoteTone notice,
  required final SlipNoteTone said,
  required final SlipNoteTone annoyed,
}) extends ThemeExtension<AppSlipNoteColors> {
  static const AppSlipNoteColors standard = AppSlipNoteColors(
    good: SlipNoteTone(background: Color(0xFFE3F3EA), ink: Color(0xFF1B6B45)),
    help: SlipNoteTone(background: Color(0xFFFDE3EA), ink: Color(0xFFB02A50)),
    notice: SlipNoteTone(background: Color(0xFFFFE9D6), ink: Color(0xFF9A4510)),
    said: SlipNoteTone(background: Color(0xFFEEE6FC), ink: Color(0xFF5F38AD)),
    annoyed: SlipNoteTone(background: Color(0xFFECEAF0), ink: Color(0xFF4F4A63)),
  );

  /// Handwriting colour on every note.
  static const Color text = Color(0xFF2A2627);

  /// Outline of the add card.
  static const Color addBorder = Color(0xFFC9C0C3);

  /// Add card label colour.
  static const Color muted = AppPalette.neutral600;

  /// Day label colour, darkened from [muted] to keep 4.5:1 on every tint.
  static const Color dayLabel = Color(0xFF686265);

  /// The colours of [type].
  SlipNoteTone of(SlipNoteType type) => switch (type) {
    .good => good,
    .help => help,
    .notice => notice,
    .said => said,
    .annoyed => annoyed,
  };

  @override
  AppSlipNoteColors copyWith({
    SlipNoteTone? good,
    SlipNoteTone? help,
    SlipNoteTone? notice,
    SlipNoteTone? said,
    SlipNoteTone? annoyed,
  }) => AppSlipNoteColors(
    good: good ?? this.good,
    help: help ?? this.help,
    notice: notice ?? this.notice,
    said: said ?? this.said,
    annoyed: annoyed ?? this.annoyed,
  );

  @override
  AppSlipNoteColors lerp(covariant AppSlipNoteColors? other, double t) =>
      t < .5 ? this : other ?? this;
}

const List<double> _tilts = [-1.6, 1.4, 1.0, -1.0];

/// The tilt in degrees of the note for [id]: one of four fixed values, the same on every build.
double slipNoteTilt(String id) {
  var hash = 0x811c9dc5;
  for (final unit in id.codeUnits) {
    hash ^= unit;
    hash = (hash * 0x01000193) & 0xFFFFFFFF;
  }

  return _tilts[hash % _tilts.length];
}
