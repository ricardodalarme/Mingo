import 'package:app/features/programs/data/data_sources/remote/programs_data_source.dart';
import 'package:app/features/programs/data/mappers/program_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ContentItemRecord item(
    String slug, {
    int position = 0,
    String? parentSlug,
    bool plusOnly = false,
    String? body,
  }) => (
    slug: slug,
    title: 'Título $slug',
    body: body,
    parentSlug: parentSlug,
    position: position,
    plusOnly: plusOnly,
  );

  group('programs', () {
    test('come in position order, each with the lessons that name it as parent', () {
      final programs = (
        programs: [item('b', position: 2), item('a', position: 1)],
        lessons: [
          item('a-2', position: 2, parentSlug: 'a'),
          item('b-1', position: 1, parentSlug: 'b'),
          item('a-1', position: 1, parentSlug: 'a'),
        ],
      ).toModel();

      expect(programs.map((program) => program.slug), ['a', 'b']);
      expect(programs.first.lessons.map((lesson) => lesson.slug), ['a-1', 'a-2']);
      expect(programs.last.lessons.map((lesson) => lesson.slug), ['b-1']);
    });

    test('a lesson with no parent belongs to no program', () {
      final programs = (
        programs: [item('a')],
        lessons: [item('orphan', parentSlug: null)],
      ).toModel();

      expect(programs.single.lessons, isEmpty);
    });

    test('a program with no lessons has none', () {
      expect(
        (programs: [item('a')], lessons: <ContentItemRecord>[]).toModel().single.lessons,
        isEmpty,
      );
    });
  });

  group('one program', () {
    test('has its lessons in day order, and the day is the lesson position', () {
      final program = (
        program: item('a', body: 'Texto', plusOnly: true),
        lessons: [
          item('a-2', position: 2),
          item('a-1', position: 1, body: 'Dia um'),
        ],
      ).toModel()!;

      expect(program.slug, 'a');
      expect(program.body, 'Texto');
      expect(program.plusOnly, isTrue);
      expect(
        [for (final lesson in program.lessons) (lesson.slug, lesson.day)],
        [('a-1', 1), ('a-2', 2)],
      );
      expect(program.lessons.first.body, 'Dia um');
    });

    test('is null when the server returned none', () {
      expect((program: null, lessons: <ContentItemRecord>[]).toModel(), isNull);
    });
  });

  test('a lesson keeps its title, text and Plus flag', () {
    final lesson = item('l', position: 3, plusOnly: true, body: 'Corpo').toLesson();

    expect(lesson.title, 'Título l');
    expect(lesson.day, 3);
    expect(lesson.plusOnly, isTrue);
    expect(lesson.body, 'Corpo');
  });
}
