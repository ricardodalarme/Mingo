import 'package:app/l10n/translations.g.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  test('the plan note uses singular counts', () {
    final l10n = Translations();
    final note = l10n.plus.freeLeft(
      games: l10n.plus.gameCount(count: 1),
      rituals: l10n.plus.ritualCount(count: 1),
      lists: l10n.plus.listCount(count: 3),
    );

    expect(note, 'No plano grátis, restam 1 jogo nesta semana, 1 ritual e 3 listas.');
    expect(note, isNot(contains('1 rituais')));
  });

  test('the plan note keeps the plural for several rituals', () {
    final l10n = Translations();

    expect(l10n.plus.ritualCount(count: 3), '3 rituais');
  });
}
