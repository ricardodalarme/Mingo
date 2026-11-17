import 'dart:typed_data';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/notes/data/data_sources/remote/notes_data_source.dart';
import 'package:app/features/notes/data/mappers/message_kind_mapper.dart';
import 'package:app/features/notes/data/mappers/sent_message_mapper.dart';
import 'package:app/features/notes/data/models/sent_message.dart';
import 'package:logger/logger.dart';
import 'package:storage_service/storage_service.dart';
import 'package:uuid/uuid.dart';

const String _bucket = 'messages';

class NotesRepository({
  required final NotesDataSource _dataSource,
  required final StorageService _storageService,
  required final AuthenticationRepository _authenticationRepository,
}) {
  final Logger _logger = Logger('NotesRepository');
  final Uuid _uuid = const Uuid();

  /// The messages the user sent, newest first, with a readable link for each drawing.
  Future<List<SentMessage>> getSent() async {
    try {
      final userId = _authenticationRepository.currentUserId;
      if (userId == null) return const [];

      final nodes = await _dataSource.getSent(userId);

      return await Future.wait([
        for (final node in nodes)
          () async {
            final fileId = node.mediaFileId;
            return node.toModel(imageUrl: fileId == null ? null : await _signedUrl(fileId));
          }(),
      ]);
    } catch (e, stack) {
      _logger.error('Failed to read sent messages', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> sendNote({required String body, required bool forWidget}) async {
    try {
      await _dataSource.send(
        kind: MessageKind.note.toRemote(),
        body: body.trim(),
        forWidget: forWidget,
      );
    } catch (e, stack) {
      _logger.error('Failed to send a note', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Uploads the [png] and then sends it as a drawing.
  Future<void> sendDrawing({required Uint8List png, required bool forWidget}) async {
    try {
      final fileId = await _storageService.upload(
        bucket: _bucket,
        bytes: png,
        contentType: 'image/png',
        name: '${_uuid.v4()}.png',
      );
      try {
        await _dataSource.send(
          kind: MessageKind.drawing.toRemote(),
          mediaFileId: fileId,
          forWidget: forWidget,
        );
      } catch (_) {
        await _removeQuietly(fileId);
        rethrow;
      }
    } catch (e, stack) {
      _logger.error('Failed to send a drawing', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Takes the message back so the partner no longer sees it, drawing file included.
  ///
  /// A row the server already removed still counts as success.
  Future<void> delete(SentMessage message) async {
    try {
      await _dataSource.delete(message.id);
      final fileId = message.mediaFileId;
      if (fileId != null) await _removeQuietly(fileId);
    } catch (e, stack) {
      _logger.error('Failed to delete a message', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<String?> _signedUrl(String fileId) async {
    try {
      return await _storageService.signedUrl(fileId: fileId);
    } catch (_) {
      return null;
    }
  }

  Future<void> _removeQuietly(String fileId) async {
    try {
      await _storageService.remove(fileId: fileId);
    } catch (e, stack) {
      _logger.error('Failed to remove a drawing file', error: e, stackTrace: stack);
    }
  }
}
