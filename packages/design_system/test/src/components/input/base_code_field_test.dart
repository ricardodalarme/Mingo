import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show TextField;

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('code field shows the mask and groups of four for ${variant.name}', (tester) async {
      await tester.pumpWidget(inputHost(const BaseCodeField(), variant: variant));

      expect(find.text('XXXX XXXX'), findsOneWidget);
    });
  }

  testWidgets('input is uppercased, cleaned, grouped and reported raw', (tester) async {
    String? last;
    String? completed;
    await tester.pumpWidget(
      inputHost(
        BaseCodeField(
          onChanged: (value) => last = value,
          onCompleted: (value) => completed = value,
        ),
        variant: AppThemeVariant.rose,
      ),
    );

    await tester.enterText(find.byType(TextField), 'k7m2-9qxa');
    expect(find.text('K7M2 9QXA'), findsOneWidget);
    expect(last, 'K7M29QXA');
    expect(completed, 'K7M29QXA');
  });

  testWidgets('input beyond the length is cut', (tester) async {
    await tester.pumpWidget(
      inputHost(const BaseCodeField(length: 4), variant: AppThemeVariant.rose),
    );

    await tester.enterText(find.byType(TextField), 'ABCDEFG');
    expect(find.text('ABCD'), findsOneWidget);
  });

  testWidgets('pin takes digits only and hides them', (tester) async {
    String? last;
    await tester.pumpWidget(
      inputHost(
        BaseCodeField(kind: .pin, length: 4, onChanged: (value) => last = value),
        variant: AppThemeVariant.rose,
      ),
    );

    await tester.enterText(find.byType(TextField), '1a2b3');
    expect(last, '123');
    expect(tester.widget<TextField>(find.byType(TextField)).obscureText, isTrue);
    expect(tester.widget<TextField>(find.byType(TextField)).keyboardType, TextInputType.number);
  });

  testWidgets('error, checking and success states render their feedback', (tester) async {
    await tester.pumpWidget(
      inputHost(const BaseCodeField(errorText: 'Code not found'), variant: AppThemeVariant.rose),
    );
    expect(find.text('Code not found'), findsOneWidget);

    await tester.pumpWidget(
      inputHost(const BaseCodeField(isChecking: true), variant: AppThemeVariant.rose),
    );
    expect(find.byType(BaseLoadingDots), findsOneWidget);

    await tester.pumpWidget(
      inputHost(const BaseCodeField(isSuccess: true), variant: AppThemeVariant.rose),
    );
    expect(find.byIcon(AppIcons.check), findsOneWidget);
  });
}
