import 'package:app/features/diary/data/data_sources/remote/diary_data_source.dart';
import 'package:app/features/diary/data/repositories/diary_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDiaryDataSource() extends Mock implements DiaryDataSource;

void main() {
  late DiaryDataSource dataSource;
  late DiaryRepository repository;

  setUp(() {
    dataSource = _MockDiaryDataSource();
    repository = DiaryRepository(dataSource: dataSource);
  });

  test('diary reads, inserts, updates and deletes only the person rows', () async {
    when(() => dataSource.getEntries()).thenAnswer(
      (_) async => [
        (id: 'j1', entryDate: DateTime(2026, 11, 10), body: 'Hoje foi calmo.', mood: 'calm'),
      ],
    );
    when(
      () => dataSource.insertEntry(
        entryDate: any(named: 'entryDate'),
        body: any(named: 'body'),
        mood: null,
      ),
    ).thenAnswer(
      (_) async => (id: 'j2', entryDate: DateTime(2026, 11, 11), body: 'Novo.', mood: null),
    );
    when(
      () => dataSource.updateEntry(
        id: any(named: 'id'),
        body: any(named: 'body'),
        mood: null,
      ),
    ).thenAnswer((_) async {
      return;
    });
    when(() => dataSource.deleteEntry(any())).thenAnswer((_) async {
      return;
    });

    final entries = await repository.getEntries();
    final id = await repository.saveEntry(entryDate: DateTime(2026, 11, 11), body: 'Novo.');
    await repository.saveEntry(entryDate: DateTime(2026, 11, 11), body: 'Editado.', id: id);
    await repository.deleteEntry(id);

    expect(entries.single.body, 'Hoje foi calmo.');
    expect(id, 'j2');
    verify(
      () => dataSource.insertEntry(entryDate: DateTime(2026, 11, 11), body: 'Novo.', mood: null),
    ).called(1);
    verify(() => dataSource.updateEntry(id: 'j2', body: 'Editado.', mood: null)).called(1);
    verify(() => dataSource.deleteEntry('j2')).called(1);
  });
}
