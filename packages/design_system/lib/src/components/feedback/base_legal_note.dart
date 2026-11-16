import 'package:design_system/design_system.dart';
import 'package:flutter/gestures.dart';

/// One tappable phrase inside a [BaseLegalNote].
class const BaseLegalLink({required final String text, required final VoidCallback onTap});

/// A short centered line of small text with links, placed right under the primary action it relates to.
///
/// [text] holds a `{}` marker for each entry of [links], in order. Links are underlined with a 3 point
/// offset in the same color and open the page through [BaseLegalLink.onTap]. Text and URLs come from the
/// locale. It is one text block for the screen reader, each link its own target.
class const BaseLegalNote({
  /// The sentence with a `{}` marker per link.
  required final String text,

  /// The links, in marker order.
  required final List<BaseLegalLink> links,
  super.key,
}) extends StatefulWidget {
  @override
  State<BaseLegalNote> createState() => _BaseLegalNoteState();
}

class _BaseLegalNoteState() extends State<BaseLegalNote> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();

    final colors = context.colors;
    final style = context.text.caption.copyWith(
      fontSize: 12.5,
      height: 18 / 12.5,
      color: colors.textSecondary,
    );
    final parts = widget.text.split('{}');
    final spans = <InlineSpan>[];
    for (var index = 0; index < parts.length; index++) {
      spans.add(TextSpan(text: parts[index]));
      if (index < parts.length - 1 && index < widget.links.length) {
        final link = widget.links[index];
        final recognizer = TapGestureRecognizer()..onTap = link.onTap;
        _recognizers.add(recognizer);
        spans.add(
          TextSpan(
            text: link.text,
            recognizer: recognizer,
            style: style.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: colors.textSecondary,
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.s16, left: AppSpace.s8, right: AppSpace.s8),
      child: Text.rich(
        TextSpan(style: style, children: spans),
        textAlign: TextAlign.center,
      ),
    );
  }
}
