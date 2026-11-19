///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';

import 'translations.g.dart';

// Path: <root>
class TranslationsPt extends Translations with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsPt({
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
             locale: AppLocale.pt,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ),
       super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
    _meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <pt>.
  final TranslationMetadata<AppLocale, Translations> _meta;
  @override
  TranslationMetadata<AppLocale, Translations> get $meta => _meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => _meta.getTranslation(key) ?? super[key];

  late final TranslationsPt _root = this; // ignore: unused_field

  @override
  TranslationsPt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsPt(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _Translations$common$pt common = _Translations$common$pt._(_root);
  @override
  late final _Translations$identity$pt identity = _Translations$identity$pt._(_root);
  @override
  late final _Translations$input$pt input = _Translations$input$pt._(_root);
  @override
  late final _Translations$media$pt media = _Translations$media$pt._(_root);
  @override
  late final _Translations$navigation$pt navigation = _Translations$navigation$pt._(_root);
}

// Path: common
class _Translations$common$pt extends Translations$common$en {
  _Translations$common$pt._(TranslationsPt root) : this._root = root, super.internal(root);

  final TranslationsPt _root; // ignore: unused_field

  // Translations
  @override
  String get loading => 'Carregando';
  @override
  String get cancel => 'Cancelar';
  @override
  String get tryAgain => 'Tentar de novo';
  @override
  String get typing => 'Digitando';
  @override
  String get youSaid => 'Você disse';
  @override
  String get send => 'Enviar';
}

// Path: identity
class _Translations$identity$pt extends Translations$identity$en {
  _Translations$identity$pt._(TranslationsPt root) : this._root = root, super.internal(root);

  final TranslationsPt _root; // ignore: unused_field

  // Translations
  @override
  String get editPhoto => 'Sua foto, alterar';
  @override
  String get mapOffline => 'O mapa precisa de conexão';
  @override
  String get mapLocationDenied => 'Permita a localização para ver o mapa';
  @override
  String get mapAllowLocation => 'Permitir localização';
  @override
  Map<String, String> get faces => {
    'good': 'Bem',
    'affectionate': 'Carinhoso',
    'tired': 'Cansado',
    'tense': 'Tenso',
    'sad': 'Triste',
    'thinking': 'Pensativo',
    'smile': 'Sorrindo',
    'other': 'Rosto',
  };
}

// Path: input
class _Translations$input$pt extends Translations$input$en {
  _Translations$input$pt._(TranslationsPt root) : this._root = root, super.internal(root);

  final TranslationsPt _root; // ignore: unused_field

  // Translations
  @override
  String get showPassword => 'Mostrar senha';
  @override
  String get hidePassword => 'Ocultar senha';
  @override
  String get search => 'Buscar';
  @override
  String get noOptions => 'Nenhuma opção';
  @override
  String get confirm => 'Confirmar';
  @override
  String get day => 'Dia';
  @override
  String get month => 'Mês';
  @override
  String get year => 'Ano';
  @override
  String get hour => 'Hora';
  @override
  String get minute => 'Minuto';
  @override
  String get increase => 'Aumentar';
  @override
  String get decrease => 'Diminuir';
  @override
  late final _Translations$input$calendar$pt calendar = _Translations$input$calendar$pt._(_root);
  @override
  String codeLabel({required Object length}) => 'Código, ${length} caracteres';
}

// Path: media
class _Translations$media$pt extends Translations$media$en {
  _Translations$media$pt._(TranslationsPt root) : this._root = root, super.internal(root);

  final TranslationsPt _root; // ignore: unused_field

  // Translations
  @override
  String get takePhoto => 'Tirar uma foto';
  @override
  String get chooseFromLibrary => 'Escolher da galeria';
  @override
  String get useInitial => 'Usar inicial e cor';
  @override
  String get removePhoto => 'Remover foto';
  @override
  String get usePhoto => 'Usar esta foto';
  @override
  String get chooseAnother => 'Escolher outra';
  @override
  String get cropHint => 'Arraste e use o gesto de pinça para ajustar a foto';
  @override
  String get zoomIn => 'Aproximar';
  @override
  String get zoomOut => 'Afastar';
  @override
  String get moveLeft => 'Mover para a esquerda';
  @override
  String get moveRight => 'Mover para a direita';
  @override
  String get moveUp => 'Mover para cima';
  @override
  String get moveDown => 'Mover para baixo';
  @override
  String get record => 'Gravar';
  @override
  String get stop => 'Parar';
  @override
  String get reRecord => 'Gravar de novo';
  @override
  String get play => 'Tocar';
  @override
  String get pause => 'Pausar';
}

// Path: navigation
class _Translations$navigation$pt extends Translations$navigation$en {
  _Translations$navigation$pt._(TranslationsPt root) : this._root = root, super.internal(root);

  final TranslationsPt _root; // ignore: unused_field

  // Translations
  @override
  String stepOf({required Object current, required Object total}) => 'Etapa ${current} de ${total}';
  @override
  String partOf({required Object current, required Object total}) => 'Parte ${current} de ${total}';
  @override
  String cardOf({required Object current, required Object total}) =>
      'Cartão ${current} de ${total}';
  @override
  String get closeMenu => 'Fechar';
}

// Path: input.calendar
class _Translations$input$calendar$pt extends Translations$input$calendar$en {
  _Translations$input$calendar$pt._(TranslationsPt root) : this._root = root, super.internal(root);

  final TranslationsPt _root; // ignore: unused_field

  // Translations
  @override
  String get previousMonth => 'Mês anterior';
  @override
  String get nextMonth => 'Próximo mês';
  @override
  String get today => 'Hoje';
  @override
  String get unavailable => 'Indisponível';
  @override
  String monthYear({required Object month, required Object year}) => '${month} de ${year}';
  @override
  String date({required Object day, required Object month, required Object year}) =>
      '${day} de ${month} de ${year}';
  @override
  List<String> get months => [
    'janeiro',
    'fevereiro',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro',
  ];
  @override
  List<String> get weekdays => ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
  @override
  String get hasEntry => 'Tem registro';
}

/// The flat map containing all translations for locale <pt>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPt {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'common.loading' => 'Carregando',
      'common.cancel' => 'Cancelar',
      'common.tryAgain' => 'Tentar de novo',
      'common.typing' => 'Digitando',
      'common.youSaid' => 'Você disse',
      'common.send' => 'Enviar',
      'identity.editPhoto' => 'Sua foto, alterar',
      'identity.mapOffline' => 'O mapa precisa de conexão',
      'identity.mapLocationDenied' => 'Permita a localização para ver o mapa',
      'identity.mapAllowLocation' => 'Permitir localização',
      'identity.faces.good' => 'Bem',
      'identity.faces.affectionate' => 'Carinhoso',
      'identity.faces.tired' => 'Cansado',
      'identity.faces.tense' => 'Tenso',
      'identity.faces.sad' => 'Triste',
      'identity.faces.thinking' => 'Pensativo',
      'identity.faces.smile' => 'Sorrindo',
      'identity.faces.other' => 'Rosto',
      'input.showPassword' => 'Mostrar senha',
      'input.hidePassword' => 'Ocultar senha',
      'input.search' => 'Buscar',
      'input.noOptions' => 'Nenhuma opção',
      'input.confirm' => 'Confirmar',
      'input.day' => 'Dia',
      'input.month' => 'Mês',
      'input.year' => 'Ano',
      'input.hour' => 'Hora',
      'input.minute' => 'Minuto',
      'input.increase' => 'Aumentar',
      'input.decrease' => 'Diminuir',
      'input.calendar.previousMonth' => 'Mês anterior',
      'input.calendar.nextMonth' => 'Próximo mês',
      'input.calendar.today' => 'Hoje',
      'input.calendar.unavailable' => 'Indisponível',
      'input.calendar.monthYear' => ({
        required Object month,
        required Object year,
      }) => '${month} de ${year}',
      'input.calendar.date' => ({
        required Object day,
        required Object month,
        required Object year,
      }) => '${day} de ${month} de ${year}',
      'input.calendar.months.0' => 'janeiro',
      'input.calendar.months.1' => 'fevereiro',
      'input.calendar.months.2' => 'março',
      'input.calendar.months.3' => 'abril',
      'input.calendar.months.4' => 'maio',
      'input.calendar.months.5' => 'junho',
      'input.calendar.months.6' => 'julho',
      'input.calendar.months.7' => 'agosto',
      'input.calendar.months.8' => 'setembro',
      'input.calendar.months.9' => 'outubro',
      'input.calendar.months.10' => 'novembro',
      'input.calendar.months.11' => 'dezembro',
      'input.calendar.weekdays.0' => 'D',
      'input.calendar.weekdays.1' => 'S',
      'input.calendar.weekdays.2' => 'T',
      'input.calendar.weekdays.3' => 'Q',
      'input.calendar.weekdays.4' => 'Q',
      'input.calendar.weekdays.5' => 'S',
      'input.calendar.weekdays.6' => 'S',
      'input.calendar.hasEntry' => 'Tem registro',
      'input.codeLabel' => ({required Object length}) => 'Código, ${length} caracteres',
      'media.takePhoto' => 'Tirar uma foto',
      'media.chooseFromLibrary' => 'Escolher da galeria',
      'media.useInitial' => 'Usar inicial e cor',
      'media.removePhoto' => 'Remover foto',
      'media.usePhoto' => 'Usar esta foto',
      'media.chooseAnother' => 'Escolher outra',
      'media.cropHint' => 'Arraste e use o gesto de pinça para ajustar a foto',
      'media.zoomIn' => 'Aproximar',
      'media.zoomOut' => 'Afastar',
      'media.moveLeft' => 'Mover para a esquerda',
      'media.moveRight' => 'Mover para a direita',
      'media.moveUp' => 'Mover para cima',
      'media.moveDown' => 'Mover para baixo',
      'media.record' => 'Gravar',
      'media.stop' => 'Parar',
      'media.reRecord' => 'Gravar de novo',
      'media.play' => 'Tocar',
      'media.pause' => 'Pausar',
      'navigation.stepOf' => ({
        required Object current,
        required Object total,
      }) => 'Etapa ${current} de ${total}',
      'navigation.partOf' => ({
        required Object current,
        required Object total,
      }) => 'Parte ${current} de ${total}',
      'navigation.cardOf' => ({
        required Object current,
        required Object total,
      }) => 'Cartão ${current} de ${total}',
      'navigation.closeMenu' => 'Fechar',
      _ => null,
    };
  }
}
