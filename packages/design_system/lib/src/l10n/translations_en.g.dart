///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element

class Translations with BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final designSystemL10n = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       _meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ) {
    _meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  final TranslationMetadata<AppLocale, Translations> _meta;
  @override
  TranslationMetadata<AppLocale, Translations> get $meta => _meta;

  /// Access flat map
  dynamic operator [](String key) => _meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) =>
      Translations(meta: meta ?? this.$meta);

  // Translations
  late final Translations$common$en common = Translations$common$en.internal(_root);
  late final Translations$identity$en identity = Translations$identity$en.internal(_root);
  late final Translations$input$en input = Translations$input$en.internal(_root);
  late final Translations$media$en media = Translations$media$en.internal(_root);
  late final Translations$navigation$en navigation = Translations$navigation$en.internal(_root);
}

// Path: common
class Translations$common$en {
  Translations$common$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Loading'
  String get loading => 'Loading';

  /// en: 'Cancel'
  String get cancel => 'Cancel';

  /// en: 'Try again'
  String get tryAgain => 'Try again';

  /// en: 'Typing'
  String get typing => 'Typing';

  /// en: 'You said'
  String get youSaid => 'You said';

  /// en: 'Send'
  String get send => 'Send';
}

// Path: identity
class Translations$identity$en {
  Translations$identity$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Your photo, change'
  String get editPhoto => 'Your photo, change';

  /// en: 'The map needs a connection'
  String get mapOffline => 'The map needs a connection';

  /// en: 'Allow location to see the map'
  String get mapLocationDenied => 'Allow location to see the map';

  /// en: 'Allow location'
  String get mapAllowLocation => 'Allow location';

  Map<String, String> get faces => {
    'good': 'Good',
    'affectionate': 'Affectionate',
    'tired': 'Tired',
    'tense': 'Tense',
    'sad': 'Sad',
    'thinking': 'Thinking',
    'smile': 'Smile',
    'other': 'Face',
  };
}

// Path: input
class Translations$input$en {
  Translations$input$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Show password'
  String get showPassword => 'Show password';

  /// en: 'Hide password'
  String get hidePassword => 'Hide password';

  /// en: 'Search'
  String get search => 'Search';

  /// en: 'No options'
  String get noOptions => 'No options';

  /// en: 'Confirm'
  String get confirm => 'Confirm';

  /// en: 'Day'
  String get day => 'Day';

  /// en: 'Month'
  String get month => 'Month';

  /// en: 'Year'
  String get year => 'Year';

  /// en: 'Hour'
  String get hour => 'Hour';

  /// en: 'Minute'
  String get minute => 'Minute';

  /// en: 'Increase'
  String get increase => 'Increase';

  /// en: 'Decrease'
  String get decrease => 'Decrease';

  late final Translations$input$calendar$en calendar = Translations$input$calendar$en.internal(
    _root,
  );

  /// en: 'Code, {length} characters'
  String codeLabel({required Object length}) => 'Code, ${length} characters';
}

// Path: media
class Translations$media$en {
  Translations$media$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Take a photo'
  String get takePhoto => 'Take a photo';

  /// en: 'Choose from library'
  String get chooseFromLibrary => 'Choose from library';

  /// en: 'Use initial and color'
  String get useInitial => 'Use initial and color';

  /// en: 'Remove photo'
  String get removePhoto => 'Remove photo';

  /// en: 'Use this photo'
  String get usePhoto => 'Use this photo';

  /// en: 'Choose another'
  String get chooseAnother => 'Choose another';

  /// en: 'Drag and pinch to adjust the photo'
  String get cropHint => 'Drag and pinch to adjust the photo';

  /// en: 'Zoom in'
  String get zoomIn => 'Zoom in';

  /// en: 'Zoom out'
  String get zoomOut => 'Zoom out';

  /// en: 'Move left'
  String get moveLeft => 'Move left';

  /// en: 'Move right'
  String get moveRight => 'Move right';

  /// en: 'Move up'
  String get moveUp => 'Move up';

  /// en: 'Move down'
  String get moveDown => 'Move down';

  /// en: 'Record'
  String get record => 'Record';

  /// en: 'Stop'
  String get stop => 'Stop';

  /// en: 'Record again'
  String get reRecord => 'Record again';

  /// en: 'Play'
  String get play => 'Play';

  /// en: 'Pause'
  String get pause => 'Pause';
}

// Path: navigation
class Translations$navigation$en {
  Translations$navigation$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Step {current} of {total}'
  String stepOf({required Object current, required Object total}) => 'Step ${current} of ${total}';

  /// en: 'Part {current} of {total}'
  String partOf({required Object current, required Object total}) => 'Part ${current} of ${total}';

  /// en: 'Card {current} of {total}'
  String cardOf({required Object current, required Object total}) => 'Card ${current} of ${total}';
}

// Path: input.calendar
class Translations$input$calendar$en {
  Translations$input$calendar$en.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// en: 'Previous month'
  String get previousMonth => 'Previous month';

  /// en: 'Next month'
  String get nextMonth => 'Next month';

  /// en: 'Today'
  String get today => 'Today';

  /// en: 'Unavailable'
  String get unavailable => 'Unavailable';

  /// en: '{month} {year}'
  String monthYear({required Object month, required Object year}) => '${month} ${year}';

  /// en: '{day} {month} {year}'
  String date({required Object day, required Object month, required Object year}) =>
      '${day} ${month} ${year}';

  List<String> get months => [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List<String> get weekdays => ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  /// en: 'Has an entry'
  String get hasEntry => 'Has an entry';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'common.loading' => 'Loading',
      'common.cancel' => 'Cancel',
      'common.tryAgain' => 'Try again',
      'common.typing' => 'Typing',
      'common.youSaid' => 'You said',
      'common.send' => 'Send',
      'identity.editPhoto' => 'Your photo, change',
      'identity.mapOffline' => 'The map needs a connection',
      'identity.mapLocationDenied' => 'Allow location to see the map',
      'identity.mapAllowLocation' => 'Allow location',
      'identity.faces.good' => 'Good',
      'identity.faces.affectionate' => 'Affectionate',
      'identity.faces.tired' => 'Tired',
      'identity.faces.tense' => 'Tense',
      'identity.faces.sad' => 'Sad',
      'identity.faces.thinking' => 'Thinking',
      'identity.faces.smile' => 'Smile',
      'identity.faces.other' => 'Face',
      'input.showPassword' => 'Show password',
      'input.hidePassword' => 'Hide password',
      'input.search' => 'Search',
      'input.noOptions' => 'No options',
      'input.confirm' => 'Confirm',
      'input.day' => 'Day',
      'input.month' => 'Month',
      'input.year' => 'Year',
      'input.hour' => 'Hour',
      'input.minute' => 'Minute',
      'input.increase' => 'Increase',
      'input.decrease' => 'Decrease',
      'input.calendar.previousMonth' => 'Previous month',
      'input.calendar.nextMonth' => 'Next month',
      'input.calendar.today' => 'Today',
      'input.calendar.unavailable' => 'Unavailable',
      'input.calendar.monthYear' => ({
        required Object month,
        required Object year,
      }) => '${month} ${year}',
      'input.calendar.date' => ({
        required Object day,
        required Object month,
        required Object year,
      }) => '${day} ${month} ${year}',
      'input.calendar.months.0' => 'January',
      'input.calendar.months.1' => 'February',
      'input.calendar.months.2' => 'March',
      'input.calendar.months.3' => 'April',
      'input.calendar.months.4' => 'May',
      'input.calendar.months.5' => 'June',
      'input.calendar.months.6' => 'July',
      'input.calendar.months.7' => 'August',
      'input.calendar.months.8' => 'September',
      'input.calendar.months.9' => 'October',
      'input.calendar.months.10' => 'November',
      'input.calendar.months.11' => 'December',
      'input.calendar.weekdays.0' => 'S',
      'input.calendar.weekdays.1' => 'M',
      'input.calendar.weekdays.2' => 'T',
      'input.calendar.weekdays.3' => 'W',
      'input.calendar.weekdays.4' => 'T',
      'input.calendar.weekdays.5' => 'F',
      'input.calendar.weekdays.6' => 'S',
      'input.calendar.hasEntry' => 'Has an entry',
      'input.codeLabel' => ({required Object length}) => 'Code, ${length} characters',
      'media.takePhoto' => 'Take a photo',
      'media.chooseFromLibrary' => 'Choose from library',
      'media.useInitial' => 'Use initial and color',
      'media.removePhoto' => 'Remove photo',
      'media.usePhoto' => 'Use this photo',
      'media.chooseAnother' => 'Choose another',
      'media.cropHint' => 'Drag and pinch to adjust the photo',
      'media.zoomIn' => 'Zoom in',
      'media.zoomOut' => 'Zoom out',
      'media.moveLeft' => 'Move left',
      'media.moveRight' => 'Move right',
      'media.moveUp' => 'Move up',
      'media.moveDown' => 'Move down',
      'media.record' => 'Record',
      'media.stop' => 'Stop',
      'media.reRecord' => 'Record again',
      'media.play' => 'Play',
      'media.pause' => 'Pause',
      'navigation.stepOf' => ({
        required Object current,
        required Object total,
      }) => 'Step ${current} of ${total}',
      'navigation.partOf' => ({
        required Object current,
        required Object total,
      }) => 'Part ${current} of ${total}',
      'navigation.cardOf' => ({
        required Object current,
        required Object total,
      }) => 'Card ${current} of ${total}',
      _ => null,
    };
  }
}
