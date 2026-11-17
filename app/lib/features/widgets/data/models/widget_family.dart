/// A group in the widgets gallery (`X-145`).
enum WidgetGalleryGroup() {
  favorites,
  medium,
  ownSmall,
  ownMedium,
}

/// Preview footprint inside the gallery and detail screens.
enum WidgetPreviewSize() {
  small,
  medium,
}

/// A widget family as the gallery and preview screens present it.
///
/// A family may share a native widget kind with another family: the native
/// personal widgets rotate through their content instead of offering one widget
/// per function.
enum WidgetFamily() {
  counter,
  counterMedium,
  partnerMood,
  longing,
  ritual,
  partnerNote,
  cardEncounter,
  distance,
  ownSlip,
  ownNextDate,
  ownRitual,
  ownSundayCard,
  ownWeek,
  ownIdea,
  ownMediumDate,
}

extension WidgetFamilyLayout on WidgetFamily {
  /// The gallery group the family belongs to.
  WidgetGalleryGroup get group => switch (this) {
    .counter || .partnerMood || .longing || .ritual || .counterMedium => .favorites,
    .partnerNote || .cardEncounter || .distance => .medium,
    .ownSlip || .ownNextDate || .ownRitual || .ownSundayCard => .ownSmall,
    .ownWeek || .ownIdea || .ownMediumDate => .ownMedium,
  };

  /// The preview footprint.
  WidgetPreviewSize get size => switch (this) {
    .counterMedium ||
    .partnerNote ||
    .cardEncounter ||
    .distance ||
    .ownWeek ||
    .ownIdea ||
    .ownMediumDate => .medium,
    _ => .small,
  };

  /// Whether the family needs a partner to have content.
  bool get requiresPartner => switch (this) {
    .counter || .partnerMood || .longing || .partnerNote || .cardEncounter || .distance => true,
    _ => false,
  };

  /// Whether the family is a couple widget.
  bool get isCouple => group == .favorites || group == .medium;
}

/// The families in each gallery group, in board order.
const List<WidgetFamily> widgetFamilyFavorites = [
  WidgetFamily.counter,
  WidgetFamily.partnerMood,
  WidgetFamily.longing,
  WidgetFamily.ritual,
];

/// Medium widgets shown under the favorites rail.
const List<WidgetFamily> widgetFamilyMedium = [
  WidgetFamily.partnerNote,
  WidgetFamily.cardEncounter,
  WidgetFamily.distance,
];

/// Small personal widgets (`X-146`).
const List<WidgetFamily> widgetFamilyOwnSmall = [
  WidgetFamily.ownSlip,
  WidgetFamily.ownNextDate,
  WidgetFamily.ownRitual,
  WidgetFamily.ownSundayCard,
];

/// Medium personal widgets (`X-147`).
const List<WidgetFamily> widgetFamilyOwnMedium = [
  WidgetFamily.ownWeek,
  WidgetFamily.ownIdea,
  WidgetFamily.ownMediumDate,
];

extension WidgetPreviewAspect on WidgetPreviewSize {
  /// The natural widget shape: square small, wide medium.
  double get aspectRatio => switch (this) {
    .small => 1,
    .medium => 1.9,
  };
}
