import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('icon sizes follow the catalog', () {
    expect(
      [AppIconSize.xs, AppIconSize.sm, AppIconSize.md, AppIconSize.lg, AppIconSize.xl],
      [14, 18, 20, 22, 26],
    );
  });

  test('the dashed border is 4 on and 4 off', () {
    expect(AppBorder.dashPattern, [4, 4]);
  });
}
