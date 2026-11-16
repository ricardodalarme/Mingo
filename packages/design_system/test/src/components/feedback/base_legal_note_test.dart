import 'package:design_system/design_system.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('legal note centers the sentence and underlines the links for ${variant.name}', (
      tester,
    ) async {
      await tester.pumpWidget(
        galleryHost(
          BaseLegalNote(
            text: 'By continuing you agree to the {} and the {}.',
            links: [
              BaseLegalLink(text: 'Terms', onTap: () {}),
              BaseLegalLink(text: 'Privacy Policy', onTap: () {}),
            ],
          ),
          variant: variant,
        ),
      );

      final text = tester.widget<RichText>(find.byType(RichText).first);
      expect(text.textAlign, TextAlign.center);
      final root = (text.text as TextSpan).children!.whereType<TextSpan>().first;
      final spans = root.children!.whereType<TextSpan>().toList();
      expect(spans.map((span) => span.text), [
        'By continuing you agree to the ',
        'Terms',
        ' and the ',
        'Privacy Policy',
        '.',
      ]);
      expect(spans[1].style!.decoration, TextDecoration.underline);
    });
  }

  testWidgets('links report their own taps', (tester) async {
    final taps = <String>[];
    await tester.pumpWidget(
      galleryHost(
        BaseLegalNote(
          text: 'See {} or {}',
          links: [
            BaseLegalLink(text: 'Terms', onTap: () => taps.add('terms')),
            BaseLegalLink(text: 'Privacy', onTap: () => taps.add('privacy')),
          ],
        ),
        variant: AppThemeVariant.rose,
      ),
    );

    final richText = find.byType(RichText).first;
    final box = tester.renderObject<RenderParagraph>(richText);
    final text = (tester.widget<RichText>(richText).text as TextSpan).toPlainText();
    for (final word in ['Terms', 'Privacy']) {
      final start = text.indexOf(word);
      final rects = box.getBoxesForSelection(
        TextSelection(baseOffset: start, extentOffset: start + word.length),
      );
      await tester.tapAt(box.localToGlobal(rects.first.toRect().center));
    }
    expect(taps, ['terms', 'privacy']);
  });
}
