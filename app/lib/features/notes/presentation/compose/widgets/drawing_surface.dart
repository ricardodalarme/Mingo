import 'package:app/features/notes/presentation/compose/cubit/compose_cubit.dart';
import 'package:app/features/notes/presentation/compose/widgets/drawing_canvas.dart';
import 'package:app/features/notes/presentation/compose/widgets/drawing_painter.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double _penSize = 32;

/// The drawing mode: a full-screen sheet with the pens, eraser and undo, and no page chrome or scroll.
class const DrawingSurface({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notes;
    final strokes = context.select((ComposeCubit cubit) => cubit.state.strokes);
    final tool = context.select((ComposeCubit cubit) => cubit.state.tool);
    final penIndex = context.select((ComposeCubit cubit) => cubit.state.penIndex);
    final cubit = context.read<ComposeCubit>();

    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        cubit.finishDrawing();
      },
      child: BaseView(
        appBar: BaseAppBar(
          title: l10n.drawingAlt,
          onClose: cubit.finishDrawing,
          trailing: BaseTextLink(text: l10n.done, onPressed: cubit.finishDrawing),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpace.screenMargin,
            0,
            AppSpace.screenMargin,
            AppSpace.s16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                child: Center(child: AspectRatio(aspectRatio: 1, child: DrawingCanvas())),
              ),
              const SizedBox(height: AppSpace.s12),
              Row(
                spacing: AppSpace.s12,
                children: [
                  for (var index = 0; index < drawingPens.length; index++)
                    _PenDot(
                      color: drawingPens[index],
                      label: l10n.pens[index],
                      isSelected: tool == DrawingTool.pen && penIndex == index,
                      onTap: () => cubit.onPenChanged(index),
                    ),
                ],
              ),
              const SizedBox(height: AppSpace.s12),
              Wrap(
                spacing: AppSpace.s8,
                runSpacing: AppSpace.s8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  BaseChoiceChip(
                    label: l10n.eraser,
                    isSelected: tool == DrawingTool.eraser,
                    onTap: () => cubit.onToolChanged(
                      tool == DrawingTool.eraser ? DrawingTool.pen : DrawingTool.eraser,
                    ),
                  ),
                  if (strokes.isNotEmpty) ...[
                    BaseTextLink(text: l10n.undo, onPressed: cubit.undo),
                    BaseTextLink(text: l10n.clear, onPressed: cubit.clearDrawing),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _PenDot({
  required final Color color,
  required final String label,
  required final bool isSelected,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppMotion.fast,
          width: _penSize,
          height: _penSize,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: context.colors.borderSelected,
              width: isSelected ? AppBorder.focus : 0,
            ),
          ),
        ),
      ),
    );
  }
}
