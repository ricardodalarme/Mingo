/// A home-screen widget the app ships, one per function.
enum HomeWidgetKind() {
  counter,
  partnerMood,
  longing,
  ritual,
  partnerNote,
  card,
  distance,
  slip,
  nextDate,
  week,
  idea,
}

/// A size a home widget comes in.
enum HomeWidgetSize() {
  small,
  medium,
}

/// One home widget in the gallery: a `kind` at a `size`.
typedef HomeWidgetVariant = ({HomeWidgetKind kind, HomeWidgetSize size});

/// A section of the gallery.
enum HomeWidgetGalleryGroup() {
  favorites,
  small,
  medium,
}

extension HomeWidgetKindTraits on HomeWidgetKind {
  /// Whether the home widget only has something to show once a partner is connected.
  bool get needsPartner => switch (this) {
    .partnerMood || .longing || .partnerNote || .distance => true,
    _ => false,
  };
}

extension HomeWidgetGalleryGroupContent on HomeWidgetGalleryGroup {
  /// The home widgets in the group, in gallery order.
  List<HomeWidgetVariant> get variants => switch (this) {
    .favorites => const [
      (kind: .counter, size: .small),
      (kind: .partnerMood, size: .small),
      (kind: .longing, size: .small),
      (kind: .ritual, size: .small),
    ],
    .small => const [
      (kind: .partnerNote, size: .small),
      (kind: .slip, size: .small),
      (kind: .nextDate, size: .small),
      (kind: .card, size: .small),
    ],
    .medium => const [
      (kind: .counter, size: .medium),
      (kind: .partnerNote, size: .medium),
      (kind: .card, size: .medium),
      (kind: .week, size: .medium),
      (kind: .idea, size: .medium),
      (kind: .nextDate, size: .medium),
      (kind: .distance, size: .medium),
    ],
  };
}

extension HomeWidgetVariantLabel on HomeWidgetVariant {
  /// The translation key of the home widget's gallery label, such as `counterMedium`.
  String get labelKey => '${kind.name}${size.name[0].toUpperCase()}${size.name.substring(1)}';
}
