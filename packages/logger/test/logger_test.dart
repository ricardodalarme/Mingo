import 'dart:async';

import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() {
  late List<LogRecord> records;
  late StreamSubscription<LogRecord> listener;

  setUp(() {
    Logger.level = LogLevel.ALL;
    records = [];
    listener = Logger.records.listen(records.add);
  });

  tearDown(() => listener.cancel());

  test('a record carries the name, the level and the message', () async {
    Logger('Probe').warning('something slow');
    await pumpEventQueue();

    expect(records.single.loggerName, 'Probe');
    expect(records.single.level, LogLevel.WARNING);
    expect(records.single.message, 'something slow');
  });

  test('an error and its stack trace travel with the record', () async {
    final stack = StackTrace.current;
    Logger('Probe').error('failed', error: StateError('boom'), stackTrace: stack);
    await pumpEventQueue();

    expect(records.single.error, isA<StateError>());
    expect(records.single.stackTrace, stack);
  });

  test('each level is its own record level', () async {
    Logger('Probe')
      ..debug('a')
      ..info('b')
      ..warning('c')
      ..error('d');
    await pumpEventQueue();

    expect(records.map((record) => record.level), [
      LogLevel.FINE,
      LogLevel.INFO,
      LogLevel.WARNING,
      LogLevel.SEVERE,
    ]);
  });

  test('a level above the record is filtered out', () async {
    Logger.level = LogLevel.WARNING;

    Logger('Probe')
      ..debug('hidden')
      ..warning('shown');
    await pumpEventQueue();

    expect(records.map((record) => record.message), ['shown']);
  });
}
