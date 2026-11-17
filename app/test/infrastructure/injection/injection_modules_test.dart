import 'package:app/features/dates/data/repositories/dates_repository.dart';
import 'package:app/features/distance/data/repositories/distance_repository.dart';
import 'package:app/infrastructure/injection/injection_modules.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dates and distance are created without creating the widgets that read them', () {
    registerInjectionModules();
    final injector = AppInjector.instance;

    expect(injector.get<DatesRepository>, returnsNormally);
    expect(injector.get<DistanceRepository>, returnsNormally);
  });
}
