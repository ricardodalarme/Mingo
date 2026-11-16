import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/chat/data/data_sources/remote/chat_data_source.dart';
import 'package:app/features/chat/data/data_sources/remote/dtos/chat_request_dto.dart';
import 'package:app/features/chat/data/mappers/chat_mapper.dart';
import 'package:app/features/chat/data/models/chat_models.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:clock/clock.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

/// The longest slip body, so a long reply is cut instead of refused.
const int _slipMaxLength = 280;

/// What the app knows before the first message.
typedef ChatStatus = ({int messagesLeft, int limit, bool hasPlus});

class ChatRepository({
  required final ChatDataSource _dataSource,
  required final ProfileRepository _profileRepository,
  required final AuthenticationRepository _authenticationRepository,
  required final SlipRepository _slipRepository,
  required final PlusRepository _plusRepository,
}) {
  final Logger _logger = Logger('ChatRepository');
  final Uuid _uuid = const Uuid();

  /// How many messages are left today and whether the person has Plus.
  Future<ChatStatus> getStatus() async {
    try {
      final (settings, plus) = await (
        _profileRepository.getMySettings(),
        _plusRepository.getPlus(),
      ).wait;
      final status = await _dataSource.getStatus(settings.profileId);

      return (
        messagesLeft: status.messagesLeft,
        limit: plus.hasPlus ? status.plusLimit : status.freeLimit,
        hasPlus: plus.hasPlus,
      );
    } catch (e, stack) {
      _logger.error('Failed to read the chat status', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Streams the reply to [message], with the last turns of [history] for context.
  Stream<ChatEvent> send({
    required String message,
    required List<ChatMessage> history,
    required String locale,
    required ChatMode mode,
    required String session,
  }) async* {
    final turns = [
      for (final item in history)
        if (item.text.trim().isNotEmpty) (role: item.role, text: item.text),
    ];
    final recent = turns.length > chatHistoryTurns
        ? turns.sublist(turns.length - chatHistoryTurns)
        : turns;
    final events = _dataSource.send(
      request: ChatRequestDto(
        message: message,
        locale: locale,
        mode: mode.toRemote(),
        session: session,
        history: [
          for (final turn in recent) ChatTurnDto(role: turn.role.toRemote(), text: turn.text),
        ],
      ),
      accessToken: _authenticationRepository.getAccessToken(),
    );
    await for (final event in events) {
      yield event.toModel();
    }
  }

  /// Turns a reply into a slip, cut to the slip limit; a queued save is fine when offline.
  Future<void> saveAsSlip(String text) async {
    final body = text.trim();
    try {
      await _slipRepository.saveQuick(
        id: _uuid.v4(),
        body: body.length > _slipMaxLength ? body.substring(0, _slipMaxLength) : body,
        createdAt: clock.now(),
      );
    } catch (e, stack) {
      _logger.error('Failed to save a reply as a slip', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
