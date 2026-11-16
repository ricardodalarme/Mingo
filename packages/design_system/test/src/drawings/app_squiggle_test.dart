import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/widget_host.dart';

void main() {
  testWidgets('renders highlighted text with the highlighted word', (tester) async {
    await tester.pumpWidget(
      themedHost(
        const AppHighlightedText(
          text: 'One calm thing',
          highlight: 'calm',
          style: TextStyle(fontSize: 26),
        ),
      ),
    );

    expect(find.byType(AppHighlightedText), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('trailing punctuation travels with the highlighted word', (tester) async {
    await tester.pumpWidget(
      themedHost(
        const SizedBox(
          width: 160,
          child: AppHighlightedText(
            text: 'What makes you smile?',
            highlight: 'smile',
            style: TextStyle(fontSize: 26),
          ),
        ),
      ),
    );

    final word = find.textContaining('smile?', findRichText: true);
    expect(word, findsOneWidget);
    expect(tester.getSize(word).height, lessThan(40));
  });
}
