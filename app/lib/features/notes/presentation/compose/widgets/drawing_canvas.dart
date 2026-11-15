import 'package:app/features/notes/presentation/compose/cubit/compose_cubit.dart';
import 'package:app/features/notes/presentation/compose/widgets/drawing_painter.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The white sheet a drawing sits on, rounded and outlined.
class const DrawingPaper({required final Widget child, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadius.xl);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: drawingPaper,
        borderRadius: radius,
        border: Border.all(color: context.colors.borderDefault),
      ),
      child: ClipRRect(borderRadius: radius, child: child),
    );
  }
}

/// A sheet to draw on with a finger; it fills the space it is given.
class const DrawingCanvas({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notes;
    final strokes = context.select((ComposeCubit cubit) => cubit.state.strokes);
    final cubit = context.read<ComposeCubit>();

    return Semantics(
      label: l10n.canvasLabel,
      child: DrawingPaper(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            Offset fraction(Offset local) =>
                Offset((local.dx / size.width).clamp(0, 1), (local.dy / size.height).clamp(0, 1));

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: (details) => cubit.onStrokeStarted(fraction(details.localPosition)),
              onPanUpdate: (details) => cubit.onStrokeUpdated(fraction(details.localPosition)),
              child: CustomPaint(
                size: size,
                painter: DrawingPainter(strokes: strokes),
              ),
            );
          },
        ),
      ),
    );
  }
}
