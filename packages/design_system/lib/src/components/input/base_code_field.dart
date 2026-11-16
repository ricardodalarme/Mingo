import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';
import 'package:design_system/src/components/input/field_localizations.dart';
import 'package:design_system/src/components/input/field_message.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

const double _minHeight = 96;
const double _fontSize = 30;
const double _pinDotSize = 14;
const double _messageGap = 10;

/// The kind of secret a [BaseCodeField] collects.
enum BaseCodeKind() {
  /// Letters and digits, uppercased, shown in groups such as `K7M2 9QXA`.
  code,

  /// Digits only, shown as dots with a numeric keyboard.
  pin,
}

/// The large code field, drawn when a whole screen is about entering one code.
///
/// One text field, not separate boxes, so paste and autofill work. It uppercases, ignores spaces and
/// dashes, and accepts a code that arrives already filled. Callbacks report the raw value; the display
/// adds the group spaces. [onCompleted] fires once when [length] characters are present. The standard
/// [BaseTextField] keeps its own invite code type for inline use.
class const BaseCodeField({
  final int length = 8,
  final int groupSize = 4,
  final BaseCodeKind kind = .code,
  final String? text,
  final ValueChanged<String>? onChanged,
  final ValueChanged<String>? onCompleted,
  final String? errorText,
  final bool isChecking = false,
  final bool isSuccess = false,
  final bool isEnabled = true,
  final String? semanticLabel,
  super.key,
}) extends StatefulWidget {
  @override
  State<BaseCodeField> createState() => _BaseCodeFieldState();
}

class _BaseCodeFieldState() extends State<BaseCodeField> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _hasCompleted = false;

  bool get _isPin => widget.kind == .pin;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _display(_clean(widget.text ?? '')));
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(BaseCodeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final text = widget.text;
    if (text != null && text != oldWidget.text) {
      final display = _display(_clean(text));
      if (display != _controller.text) {
        _controller.value = TextEditingValue(
          text: display,
          selection: TextSelection.collapsed(offset: display.length),
        );
      }
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  String _clean(String value) {
    final cleaned = value.replaceAll(RegExp(r'[\s-]'), '');
    final filtered = _isPin ? cleaned.replaceAll(RegExp('[^0-9]'), '') : cleaned.toUpperCase();

    return filtered.length > widget.length ? filtered.substring(0, widget.length) : filtered;
  }

  String _display(String raw) {
    if (_isPin || widget.groupSize <= 0) return raw;
    final buffer = StringBuffer();
    for (var index = 0; index < raw.length; index++) {
      if (index > 0 && index % widget.groupSize == 0) buffer.write(' ');
      buffer.write(raw[index]);
    }

    return buffer.toString();
  }

  void _handleChanged(String value) {
    final raw = _clean(value);
    widget.onChanged?.call(raw);
    if (raw.length == widget.length && !_hasCompleted) {
      _hasCompleted = true;
      widget.onCompleted?.call(raw);
    } else if (raw.length < widget.length) {
      _hasCompleted = false;
    }
  }

  String get _mask {
    if (_isPin) return List.filled(widget.length, '•').join(' ');

    return _display('X' * widget.length);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.designSystemL10nOrBase.input;
    final hasError = widget.errorText != null;
    final style = context.text.titleLg.copyWith(
      fontSize: _isPin ? _pinDotSize : _fontSize,
      height: 1.2,
      fontWeight: FontWeight.w600,
      letterSpacing: _fontSize * .14,
      color: colors.textPrimary,
    );

    final field = AnimatedContainer(
      duration: context.motionDuration(AppMotion.fast),
      constraints: const BoxConstraints(minHeight: _minHeight),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.s20),
      decoration: BoxDecoration(
        color: colors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: hasError
              ? AppPalette.errorInk
              : (_focusNode.hasFocus ? colors.borderSelected : colors.borderDefault),
          width: hasError || _focusNode.hasFocus ? AppBorder.selected : AppBorder.hair,
        ),
      ),
      alignment: Alignment.center,
      child: Material(
        type: MaterialType.transparency,
        child: FieldLocalizations(
          child: Semantics(
            label: widget.semanticLabel ?? l10n.codeLabel(length: widget.length),
            textField: true,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: widget.isEnabled,
              textAlign: TextAlign.center,
              style: style,
              cursorColor: colors.accentHighlight,
              cursorWidth: 2,
              keyboardType: _isPin ? TextInputType.number : TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              enableSuggestions: false,
              obscureText: _isPin,
              obscuringCharacter: '●',
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  final display = _display(_clean(newValue.text));

                  return TextEditingValue(
                    text: display,
                    selection: TextSelection.collapsed(offset: display.length),
                  );
                }),
              ],
              onChanged: _handleChanged,
              decoration: InputDecoration.collapsed(
                hintText: _mask,
                hintStyle: style.copyWith(color: colors.textPlaceholder),
              ),
            ),
          ),
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Opacity(opacity: widget.isEnabled ? 1 : .4, child: field),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: _messageGap),
            child: FieldMessage(text: widget.errorText!, isError: true, isCentered: true),
          )
        else if (widget.isChecking)
          const Padding(
            padding: EdgeInsets.only(top: _messageGap),
            child: Center(child: BaseLoadingDots()),
          )
        else if (widget.isSuccess)
          Padding(
            padding: const EdgeInsets.only(top: _messageGap),
            child: Center(
              child: AppIcon(icon: AppIcons.check, color: colors.textPrimary),
            ),
          ),
      ],
    );
  }
}
