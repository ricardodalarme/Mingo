import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';
import 'package:design_system/src/components/input/field_localizations.dart';
import 'package:material_ui/material_ui.dart';

const double _fieldMinHeight = 50;
const double _singleLineRadius = 25;
const double _multiLineRadius = 22;
const double _gap = 10;
const double _blockedOpacity = .5;
const int _maxLines = 5;

/// A fixed row with a growing text field, a send button and an optional leading slot.
///
/// The field grows to five lines and the radius drops from 25 to 22 above one line. Return adds a line;
/// only the button sends. It is controlled by [controller] when supplied, which keeps a draft alive across
/// rebuilds. [isSending] shows loading dots on the button while the field stays editable. [isEnabled]
/// false is the blocked or offline state: the whole bar fades to 50% and [hint] says why. Place it in the
/// footer of the view so it rides above the keyboard.
class const BaseMessageBar({
  required final ValueChanged<String> onSend,
  final TextEditingController? controller,
  final String? hint,
  final bool isEnabled = true,
  final bool isSending = false,
  final Widget? leading,
  final String? sendSemanticLabel,
  super.key,
}) extends StatefulWidget {
  @override
  State<BaseMessageBar> createState() => _BaseMessageBarState();
}

class _BaseMessageBarState() extends State<BaseMessageBar> {
  TextEditingController? _ownController;
  final FocusNode _focusNode = FocusNode();

  TextEditingController get _controller =>
      widget.controller ?? (_ownController ??= TextEditingController());

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _ownController?.dispose();
    super.dispose();
  }

  void _send() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    widget.onSend(value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.designSystemL10nOrBase.common;

    return Opacity(
      opacity: widget.isEnabled ? 1 : _blockedOpacity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: _gap,
        children: [
          if (widget.leading != null) widget.leading!,
          Expanded(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) {
                final lines = '\n'.allMatches(_controller.text).length + 1;
                final radius = lines > 1 ? _multiLineRadius : _singleLineRadius;

                return Container(
                  constraints: const BoxConstraints(minHeight: _fieldMinHeight),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpace.s18),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.bgSurface,
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      color: _focusNode.hasFocus ? colors.borderSelected : colors.borderDefault,
                      width: _focusNode.hasFocus ? AppBorder.selected : AppBorder.hair,
                    ),
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    child: FieldLocalizations(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        enabled: widget.isEnabled,
                        minLines: 1,
                        maxLines: _maxLines,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: colors.accentHighlight,
                        style: context.text.bodyLg.copyWith(
                          fontSize: 17,
                          height: 22 / 17,
                          color: colors.textPrimary,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: widget.hint,
                          hintStyle: context.text.bodyLg.copyWith(
                            fontSize: 17,
                            color: colors.textPlaceholder,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              final isEmpty = _controller.text.trim().isEmpty;

              return BaseRoundButton.primary(
                icon: AppIcons.send,
                semanticLabel: widget.sendSemanticLabel ?? l10n.send,
                isLoading: widget.isSending,
                onPressed: widget.isEnabled && !isEmpty ? _send : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
