import 'package:design_system/src/components/input/field_localizations.dart';
import 'package:design_system/src/components/input/field_message.dart';
import 'package:design_system/src/components/surfaces/base_slip_note.dart';
import 'package:design_system/src/components/surfaces/slip_note_paper.dart';
import 'package:design_system/src/theme/app_theme.dart';
import 'package:design_system/src/tokens/tokens.dart';
import 'package:flutter/services.dart' show TextInputAction;
import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart'
    show InputDecoration, Material, MaterialType, TextField;

const double _maxTextScale = 1.3;
const double _fontSize = 30;
// Paper padding (22) plus the footer's fold gap (4) already inset the counter 26 px.
const double _counterExtraInset = 8;

/// A large slip note whose text is a real, editable text field.
///
/// The note takes the tint of [type]; the counter sits at the bottom right, clear of the fold.
class const BaseSlipNoteField({
  required final SlipNoteType type,
  required final String typeLabel,
  final String? text,
  final String? hint,
  final double tilt = 0,
  final int maxLength = 140,
  final String? errorText,
  final ValueChanged<String>? onChanged,
  final bool isEnabled = true,
  super.key,
}) extends StatefulWidget {
  @override
  State<BaseSlipNoteField> createState() => _BaseSlipNoteFieldState();
}

class _BaseSlipNoteFieldState() extends State<BaseSlipNoteField> {
  late final TextEditingController _controller;
  int _length = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text ?? '');
    _length = _controller.text.length;
    _controller.addListener(_handleChanged);
  }

  @override
  void didUpdateWidget(BaseSlipNoteField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only follow a value the parent actually changed; a rebuild that repeats
    // the same text must not overwrite what the person just typed.
    final text = widget.text;
    if (text != null && text != oldWidget.text && text != _controller.text) {
      _length = text.length;
      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleChanged);
    _controller.dispose();
    super.dispose();
  }

  void _handleChanged() {
    final length = _controller.text.length;
    if (length != _length) setState(() => _length = length);
  }

  @override
  Widget build(BuildContext context) {
    final tone = context.slipNote.of(widget.type);
    final textStyle = slipNoteTextStyle(context, fontSize: _fontSize);
    final media = MediaQuery.of(context);
    final scaler = media.textScaler.clamp(maxScaleFactor: _maxTextScale);

    final note = Transform.rotate(
      angle: slipNoteRadians(widget.tilt),
      child: SlipNotePaper(
        background: tone.background,
        size: .large,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MediaQuery(
              data: media.copyWith(textScaler: scaler),
              // Owns its Material ancestor so the field works outside a Scaffold.
              child: Material(
                type: MaterialType.transparency,
                child: FieldLocalizations(
                  child: TextField(
                    controller: _controller,
                    enabled: widget.isEnabled,
                    style: textStyle,
                    cursorColor: context.colors.accentHighlight,
                    maxLines: null,
                    maxLength: widget.maxLength,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    onChanged: widget.onChanged,
                    buildCounter: (
                      _, {
                      required currentLength,
                      required isFocused,
                      required maxLength,
                    }) => null,
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hint,
                      hintStyle: textStyle.copyWith(
                        color: AppSlipNoteColors.text.withValues(alpha: .4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.s12),
            SlipNoteFooter(
              type: widget.type,
              typeLabel: widget.typeLabel,
              size: .large,
              trailing: Padding(
                padding: const EdgeInsetsDirectional.only(end: _counterExtraInset),
                child: Text(
                  '$_length/${widget.maxLength}',
                  style: context.text.micro.copyWith(
                    color: AppSlipNoteColors.dayLabel,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final errorText = widget.errorText;
    if (errorText == null) return note;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        note,
        Padding(
          padding: const EdgeInsets.only(top: AppSpace.s8, left: AppSpace.s4, right: AppSpace.s4),
          child: FieldMessage(text: errorText, isError: true),
        ),
      ],
    );
  }
}
