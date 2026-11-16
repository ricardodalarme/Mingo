import 'package:core/core.dart';
import 'package:test/test.dart';

final class const MockException(String l10nPlaceholder) extends LocalizedException {
  this : super(l10nKey: l10nPlaceholder);
}

void main() {
  group('Resource', () {
    test('Success equality', () {
      const success1 = Success<String>('value');
      const success2 = Success<String>('value');
      const success3 = Success<String>('different_value');

      expect(success1, equals(success2));
      expect(success1, isNot(equals(success3)));
    });

    test('Failure equality', () {
      const exception = MockException('error message');
      const failure1 = Failure(exception);
      const failure2 = Failure(exception);
      const failure3 = Failure(MockException('different_message'));

      expect(failure1, equals(failure2));
      expect(failure1, isNot(equals(failure3)));
    });

    test('fromObject keeps the failure a parallel wait of records came from', () async {
      const exception = MockException('network');
      Object? thrown;
      try {
        await (
          Future<int>.syncValue(1),
          Future<int>.error(exception),
          Future<int>.syncValue(3),
        ).wait;
      } on Object catch (error) {
        thrown = error;
      }

      expect(Failure.fromObject(thrown!), const Failure(exception));
    });

    test('fromObject keeps the failure a parallel wait of a list came from', () async {
      const exception = MockException('network');
      Object? thrown;
      try {
        await [Future<int>.syncValue(1), Future<int>.error(exception)].wait;
      } on Object catch (error) {
        thrown = error;
      }

      expect(Failure.fromObject(thrown!), const Failure(exception));
    });

    test('fromObject maps anything unknown to the unknown failure', () {
      expect(Failure.fromObject(Exception('x')), const Failure(UnknownException()));
    });

    test('Loading equality', () {
      const loading1 = Loading();
      const loading2 = Loading();
      expect(loading1, equals(loading2));
    });
  });
}
