import 'package:app/features/_shared/chat_actions/chat_action_handler.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:clock/clock.dart';
import 'package:uuid/uuid.dart';

/// The longest slip body, so a long suggestion is cut instead of refused.
const int _slipMaxLength = 280;

typedef _SlipText = ({String body});

_SlipText? _parseBody(Map<String, Object?> args) {
  final body = (args['body'] as String?)?.trim();
  if (body == null || body.isEmpty) return null;

  return (body: body.length > _slipMaxLength ? body.substring(0, _slipMaxLength) : body);
}

/// Keeps a small good thing as a private slip.
class CreatePrivateSlipChatHandler({required final SlipRepository _repository})
    extends TypedChatActionHandler<_SlipText> {
  @override
  String get tool => 'create_private_slip';

  @override
  _SlipText? parse(Map<String, Object?> args) => _parseBody(args);

  @override
  String? text(_SlipText args) => args.body;

  @override
  Future<void> run(_SlipText args) async {
    await _repository.saveQuick(id: const Uuid().v4(), body: args.body, createdAt: clock.now());
  }
}

/// Saves a slip and sends it to the partner right away.
class SendSlipToPartnerChatHandler({required final SlipRepository _repository})
    extends TypedChatActionHandler<_SlipText> {
  @override
  String get tool => 'send_slip_to_partner';

  @override
  _SlipText? parse(Map<String, Object?> args) => _parseBody(args);

  @override
  String? text(_SlipText args) => args.body;

  @override
  Future<void> run(_SlipText args) async {
    final id = const Uuid().v4();
    await _repository.saveQuick(id: id, body: args.body, createdAt: clock.now());
    await _repository.sendNow(id);
  }
}
