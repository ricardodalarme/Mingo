import 'package:app/features/_shared/chat_actions/chat_action_handler.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';

MoodKind? _parseMood(Map<String, Object?> args) => MoodKind.values.asNameMap()[args['mood']];

/// Records today's mood, kept private.
class LogMoodChatHandler({required final MoodRepository _repository})
    extends TypedChatActionHandler<MoodKind> {
  @override
  String get tool => 'log_mood';

  @override
  MoodKind? parse(Map<String, Object?> args) => _parseMood(args);

  @override
  String? valueKey(MoodKind args) => args.name;

  @override
  Future<void> run(MoodKind args) => _repository.saveMood(mood: args, share: MoodShare.none);
}

/// Records today's mood and shares it with the partner.
class ShareMoodChatHandler({required final MoodRepository _repository})
    extends TypedChatActionHandler<MoodKind> {
  @override
  String get tool => 'share_mood';

  @override
  MoodKind? parse(Map<String, Object?> args) => _parseMood(args);

  @override
  String? valueKey(MoodKind args) => args.name;

  @override
  Future<void> run(MoodKind args) => _repository.saveMood(mood: args, share: MoodShare.mood);
}
