import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  test('sizes are 24, 40, 64 and 104', () {
    expect(BaseAvatarSize.values.map((s) => s.diameter), [24, 40, 64, 104]);
  });

  for (final variant in AppThemeVariant.values) {
    testWidgets('xl avatar is 104 with an edit badge for ${variant.name}', (tester) async {
      var edits = 0;
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        galleryHost(
          BaseAvatar(initials: 'R', size: .xl, onEdit: () => edits++),
          variant: variant,
        ),
      );

      expect(tester.getSize(find.byType(BaseAvatar)).width, greaterThanOrEqualTo(104));
      expect(find.bySemanticsLabel('Your photo, change'), findsOneWidget);
      expect(find.byType(AppIcon), findsOneWidget);
      await tester.tap(find.byType(BaseAvatar));
      expect(edits, 1);
      semantics.dispose();
    });
  }

  testWidgets('a failed upload turns the badge into a retry icon', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        BaseAvatar(initials: 'R', size: .xl, onEdit: () {}, hasFailed: true),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(tester.widget<AppIcon>(find.byType(AppIcon)).icon, AppIcons.refresh);
  });

  testWidgets('uploading shows dots and blocks the tap', (tester) async {
    var edits = 0;
    await tester.pumpWidget(
      galleryHost(
        BaseAvatar(initials: 'R', size: .xl, onEdit: () => edits++, isUploading: true),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.byType(BaseLoadingDots), findsOneWidget);
    await tester.tap(find.byType(BaseAvatar), warnIfMissed: false);
    expect(edits, 0);
  });
}
