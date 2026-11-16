import 'package:app/features/_shared/chat_actions/chat_action_handler.dart';
import 'package:app/features/chat/data/models/learned_item.dart';
import 'package:app/features/chat/data/repositories/learned_items_repository.dart';

typedef _Text = ({String text});

_Text? _parse(Map<String, Object?> args, String key) {
  final text = (args[key] as String?)?.trim();

  return text == null || text.isEmpty ? null : (text: text);
}

/// Shows a question for the person to talk about; nothing is sent.
class SuggestCoupleQuestionChatHandler() extends TypedChatActionHandler<_Text> {
  @override
  String get tool => 'suggest_couple_question';

  @override
  bool get isInformative => true;

  @override
  _Text? parse(Map<String, Object?> args) => _parse(args, 'question');

  @override
  String? text(_Text args) => args.text;

  @override
  Future<void> run(_Text args) async {}
}

/// Shows a draft note for the person to use; nothing is sent.
class DraftNoteChatHandler() extends TypedChatActionHandler<_Text> {
  @override
  String get tool => 'draft_note';

  @override
  bool get isInformative => true;

  @override
  _Text? parse(Map<String, Object?> args) => _parse(args, 'body');

  @override
  String? text(_Text args) => args.text;

  @override
  Future<void> run(_Text args) async {}
}

typedef _Learning = ({LearnedTarget target, String text});

/// Keeps something the mascot noticed as a pending learning, for the person to review.
class SaveLearningChatHandler({required final LearnedItemsRepository _repository})
    extends TypedChatActionHandler<_Learning> {
  @override
  String get tool => 'save_learning';

  @override
  _Learning? parse(Map<String, Object?> args) {
    final text = _parse(args, 'text');
    final target = switch (args['target']) {
      'partner_fact' => LearnedTarget.partnerFact,
      'date' => LearnedTarget.date,
      'memory' => LearnedTarget.memory,
      'commitment' => LearnedTarget.commitment,
      _ => null,
    };

    return text == null || target == null ? null : (target: target, text: text.text);
  }

  @override
  String? text(_Learning args) => args.text;

  @override
  Future<void> run(_Learning args) => _repository.add(target: args.target, text: args.text);
}
