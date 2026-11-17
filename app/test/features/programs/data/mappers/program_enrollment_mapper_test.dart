import 'package:app/features/programs/data/mappers/program_enrollment_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an enrollment keeps its program, day and completion', () {
    final done = DateTime.utc(2026, 3, 20);

    final enrollment = (programSlug: 'p', currentDay: 4, completedAt: done).toModel();

    expect(enrollment.programSlug, 'p');
    expect(enrollment.currentDay, 4);
    expect(enrollment.completedAt, done);
  });

  test('an enrollment still in progress has no completion', () {
    expect((programSlug: 'p', currentDay: 1, completedAt: null).toModel().completedAt, isNull);
  });
}
