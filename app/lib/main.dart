import 'package:app/app.dart';
import 'package:app/infrastructure/initializers/initializers.dart';
import 'package:app/infrastructure/injection/injection_modules.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

final _logger = Logger('Bootstrap');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.level = kDebugMode ? LogLevel.ALL : LogLevel.WARNING;

  registerInjectionModules();
  await _runStartupPipeline();

  runApp(const App());
}

Future<void> _runStartupPipeline() async {
  final pipeline = StartupPipeline([
    AppCubitInitializer(),
    AuthenticationInitializer(),
    BlocInitializer(),
    CrashReportInitializer(),
    FirebaseInitializer(),
    LocaleInitializer(),
    NotificationsInitializer(),
    PreferencesInitializer(),
    QueryCacheInitializer(),
  ]);

  final report = await pipeline.execute();

  _logger.info('App startup completed in ${report.totalDuration.inMilliseconds}ms');

  for (final entry in report.metrics.entries) {
    _logger.debug(' • ${entry.key}: ${entry.value.inMilliseconds}ms');
  }

  for (final entry in report.errors.entries) {
    _logger.warning(' • ${entry.key}: ${entry.value}');
  }
}
