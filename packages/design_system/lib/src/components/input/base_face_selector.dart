import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

const double _itemWidth = 60;
const double _unlabeledGap = 10;

/// One entry of a [BaseFaceSelector]: a [kind] and, in the labeled form, its [label].
class const BaseFaceOption({required final FaceKind kind, final String? label});

/// A single-choice row of faces with optional labels.
///
/// Three to seven [options]. The feature maps each face to its meaning and decides what happens next:
/// the selector only reports the value. Tapping the selected face clears it when [allowClear] is true.
/// It exposes radio-group semantics; an unlabeled face reads its emotion. Never shows counts or a most
/// chosen face.
class const BaseFaceSelector({
  required final List<BaseFaceOption> options,
  required final FaceKind? value,
  required final ValueChanged<FaceKind?> onChanged,
  final bool isLabeled = true,
  final bool allowClear = true,
  final bool isEnabled = true,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final children = [for (final option in options) _item(context, option)];

    return Semantics(
      container: true,
      child: Opacity(
        opacity: isEnabled ? 1 : .4,
        child: isLabeled
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: children)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: _unlabeledGap,
                children: children,
              ),
      ),
    );
  }

  Widget _item(BuildContext context, BaseFaceOption option) {
    final colors = context.colors;
    final isSelected = option.kind == value;
    final faceNames = context.designSystemL10nOrBase.identity.faces;
    final name = faceNames[option.kind.name] ?? faceNames['other']!;
    final label = option.label ?? name;
    final face = BaseFace(
      kind: option.kind,
      size: isLabeled ? .large : .reaction,
      selected: isSelected,
    );

    return AppPressable(
      onTap: () {
        AppHaptics.selection();
        onChanged(isSelected && allowClear ? null : option.kind);
      },
      isEnabled: isEnabled,
      isSelected: isSelected,
      semanticLabel: label,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      enforceMinTapTarget: true,
      child: ExcludeSemantics(
        child: isLabeled
            ? SizedBox(
                width: _itemWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpace.s6,
                  children: [
                    face,
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: context.text.micro.copyWith(
                        color: isSelected ? colors.textPrimary : colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              )
            : face,
      ),
    );
  }
}
