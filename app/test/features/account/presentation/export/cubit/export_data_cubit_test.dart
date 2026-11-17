import 'package:app/features/account/data/repositories/account_repository.dart';
import 'package:app/features/account/presentation/export/cubit/export_data_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAccountRepository() extends Mock implements AccountRepository;

void main() {
  late AccountRepository repository;
  final link = Uri.parse('https://files.test/a.json');

  setUp(() => repository = _MockAccountRepository());

  blocTest<ExportDataCubit, ExportDataState>(
    'exporting gives the link',
    setUp: () => when(repository.exportData).thenAnswer((_) async => link),
    build: () => ExportDataCubit(repository: repository),
    act: (cubit) => cubit.export(),
    expect: () => [
      const ExportDataState(exportAction: Loading()),
      ExportDataState(exportAction: Success(link)),
    ],
  );

  blocTest<ExportDataCubit, ExportDataState>(
    'a failed export shows the failure',
    setUp: () => when(repository.exportData).thenThrow(Exception('limit')),
    build: () => ExportDataCubit(repository: repository),
    act: (cubit) => cubit.export(),
    verify: (cubit) => expect(cubit.state.exportAction, isA<Failure>()),
  );
}
