import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_copy.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_heart.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The note the partner sent to the home widget, on a taped sheet of ruled paper.
class const PartnerNotePreview({
  required final HomeWidgetPayload payload,
  required final HomeWidgetSize size,
  required final DateTime now,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final palette = HomeWidgetPalette.of(payload.theme);
    final isMedium = size == HomeWidgetSize.medium;
    final note = payload.partnerNote;
    final at = DateTime.tryParse(payload.partnerNoteAt ?? '')?.toLocal();
    final name = payload.partnerName;
    final time = at == null ? '' : context.arrivedText(at, now);
    final footer = note == null
        ? l10n.noteEmptyHint
        : (name == null
              ? l10n.noteFromPartner(time: time)
              : l10n.noteFromName(name: name, time: time));

    return HomeWidgetFrame(
      size: size,
      decoration: const BoxDecoration(color: HomeWidgetPalette.paper),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: HomeWidgetPalette.paperInk),
        child: Stack(
          children: [
            if (isMedium)
              Positioned.fill(
                child: CustomPaint(painter: _RulesPainter(HomeWidgetPalette.paperLine)),
              ),
            Positioned(
              left: (size.canvasWidth - (isMedium ? 70 : 56)) / 2,
              top: -6,
              child: Transform.rotate(
                angle: -0.035,
                child: Container(
                  width: isMedium ? 70 : 56,
                  height: isMedium ? 22 : 20,
                  color: palette.highlight.withValues(alpha: .28),
                ),
              ),
            ),
            Padding(
              padding: isMedium
                  ? const EdgeInsets.fromLTRB(22, 22, 22, 14)
                  : const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: isMedium ? 0 : 8),
                    child: Transform.rotate(
                      angle: isMedium ? -0.026 : -0.035,
                      alignment: Alignment.centerLeft,
                      child: note == null
                          ? HomeWidgetText(text: l10n.noteEmpty, size: 17, weight: FontWeight.w600)
                          : HomeWidgetHandText(text: note, size: isMedium ? 31 : 27),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Opacity(
                          opacity: 0.8,
                          child: HomeWidgetText(text: footer, size: 12.5, maxLines: 1),
                        ),
                      ),
                      if (isMedium && note != null)
                        HomeWidgetHeart(size: 18, color: palette.highlight),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RulesPainter(final Color color) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (var y = 31.5; y < size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_RulesPainter oldDelegate) => oldDelegate.color != color;
}
