import 'package:auto_route/auto_route.dart';

/// A suggestion from the mascot, understood and ready to run.
final class const PreparedChatAction({
  required final Future<void> Function() run,
  final String? text,
  final String? valueKey,
  final PageRouteInfo<Object?>? route,
  final bool isInformative = false,
});

/// Understands one tool of the mascot on behalf of the feature that owns it.
///
/// A feature registers its handlers in a [ChatActionRegistry]; the chat never imports the feature.
abstract interface class ChatActionHandler() {
  /// The tool name the backend streams.
  String get tool;

  /// Reads the raw arguments, or returns null when they are not valid for this tool.
  PreparedChatAction? prepare(Map<String, Object?> args);
}

/// A [ChatActionHandler] whose arguments are parsed into [A] once, so the feature works with a typed value.
abstract class TypedChatActionHandler<A extends Object>() implements ChatActionHandler {
  /// Reads the raw arguments, or returns null when they are not valid.
  A? parse(Map<String, Object?> args);

  /// Carries out the action.
  Future<void> run(A args);

  /// The words the card shows for [args], if any.
  String? text(A args) => null;

  /// The closed value the card translates for [args], if any.
  String? valueKey(A args) => null;

  /// A page the card opens instead of running, if any.
  PageRouteInfo<Object?>? route(A args) => null;

  /// Whether the card only shows text, with nothing to run.
  bool get isInformative => false;

  @override
  PreparedChatAction? prepare(Map<String, Object?> args) {
    final typed = parse(args);
    if (typed == null) return null;

    return PreparedChatAction(
      run: () => run(typed),
      text: text(typed),
      valueKey: valueKey(typed),
      route: route(typed),
      isInformative: isInformative,
    );
  }
}

/// The handlers features add for the chat to use.
class ChatActionRegistry() {
  final Map<String, ChatActionHandler Function()> _factories = {};
  final Map<String, ChatActionHandler> _handlers = {};

  /// Adds a handler built on first use, so its dependencies may be registered later.
  void register(String tool, ChatActionHandler Function() create) => _factories[tool] = create;

  /// The prepared action for [tool], or null when no feature handles it or the arguments are not valid.
  PreparedChatAction? prepare(String tool, Map<String, Object?> args) {
    final factory = _factories[tool];
    if (factory == null) return null;

    return (_handlers[tool] ??= factory()).prepare(args);
  }
}
