import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the gallery favorites follow the board order', () {
    expect(widgetFamilyFavorites, [
      WidgetFamily.counter,
      WidgetFamily.partnerMood,
      WidgetFamily.longing,
      WidgetFamily.ritual,
    ]);
  });

  test('medium families are the note, the card and the distance', () {
    expect(widgetFamilyMedium, [
      WidgetFamily.partnerNote,
      WidgetFamily.cardEncounter,
      WidgetFamily.distance,
    ]);
    expect(widgetFamilyMedium.every((family) => family.size == WidgetPreviewSize.medium), isTrue);
  });

  test('the personal screens split small and medium widgets', () {
    expect(widgetFamilyOwnSmall, hasLength(4));
    expect(widgetFamilyOwnMedium, hasLength(3));
    expect(
      widgetFamilyOwnSmall.every((family) => family.group == WidgetGalleryGroup.ownSmall),
      isTrue,
    );
    expect(
      widgetFamilyOwnMedium.every((family) => family.group == WidgetGalleryGroup.ownMedium),
      isTrue,
    );
  });

  test('a couple family needs a partner and a personal family does not', () {
    expect(WidgetFamily.counter.requiresPartner, isTrue);
    expect(WidgetFamily.partnerNote.requiresPartner, isTrue);
    expect(WidgetFamily.ownWeek.requiresPartner, isFalse);
    expect(WidgetFamily.ownSundayCard.isCouple, isFalse);
  });
}
