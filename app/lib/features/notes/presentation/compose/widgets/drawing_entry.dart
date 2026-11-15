import 'package:app/features/notes/presentation/compose/cubit/compose_cubit.dart';
import 'package:app/features/notes/presentation/compose/widgets/drawing_canvas.dart';
import 'package:app/features/notes/presentation/compose/widgets/drawing_painter.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The compose entry to drawing: the current drawing or the prompt to start one.
class const DrawingEntry({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notes;
    final strokes = context.select((ComposeCubit cubit) => cubit.state.strokes);
    final cubit = context.read<ComposeCubit>();
    final hasStrokes = strokes.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasStrokes) ...[
          Semantics(
            image: true,
            label: l10n.drawingAlt,
            child: AspectRatio(
              aspectRatio: 1,
              child: DrawingPaper(
                child: CustomPaint(painter: DrawingPainter(strokes: strokes)),
              ),
            ),
          ),
          const SizedBox(height: AppSpace.s12),
        ],
        BaseButton.secondary(
          text: hasStrokes ? l10n.continueDrawing : l10n.startDrawing,
          icon: AppIcons.pencil,
          isFullWidth: true,
          onPressed: cubit.startDrawing,
        ),
        if (!hasStrokes) ...[
          const SizedBox(height: AppSpace.s8),
          Text(
            l10n.emptyDrawing,
            style: context.text.bodySm.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ],
    );
  }
}
