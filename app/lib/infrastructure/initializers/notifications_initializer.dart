import 'dart:developer';

import 'package:app/infrastructure/initializers/firebase_initializer.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';
import 'package:notification_service/notification_service.dart';

@pragma('vm:entry-point')
Future<void> notificationBackgroundHandler(Object message) async {
  final notification = NotificationMessage.fromRemoteMessage(message);

  log('Notification received in background: ${notification.id}', name: 'notification');
}

final class NotificationsInitializer() extends Initializer {
  static final Logger _logger = Logger('NotificationsInitializer');

  @override
  List<Type> get dependencies => const [FirebaseInitializer];

  @override
  void initialize() {
    _logger.info('Registering notification background handler');

    AppInjector.instance.get<NotificationService>().registerBackgroundMessageHandler(
      notificationBackgroundHandler,
    );
  }
}
