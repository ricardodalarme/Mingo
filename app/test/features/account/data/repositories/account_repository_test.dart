import 'package:app/features/account/data/data_sources/remote/account_data_source.dart';
import 'package:app/features/account/data/data_sources/remote/mutations/generated/RequestAccountDeletion.graphql.dart';
import 'package:app/features/account/data/data_sources/remote/queries/generated/MyDeletionRequest.graphql.dart';
import 'package:app/features/account/data/repositories/account_repository.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAccountDataSource() extends Mock implements AccountDataSource;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late AccountDataSource dataSource;

  setUp(() => dataSource = _MockAccountDataSource());

  AccountRepository build() {
    final authenticationRepository = _MockAuthenticationRepository();
    when(() => authenticationRepository.currentUserId).thenReturn('u1');

    return AccountRepository(
      dataSource: dataSource,
      authenticationRepository: authenticationRepository,
    );
  }

  test('a missing request is null', () async {
    when(() => dataSource.getDeletion('u1')).thenAnswer((_) async => null);

    expect(await build().getDeletion(), isNull);
  });

  test('the request keeps both dates', () async {
    when(() => dataSource.getDeletion('u1')).thenAnswer(
      (_) async => QueryMyDeletionRequestdeletionRequestsByPk(
        requestedAt: DateTime(2026, 11, 10),
        purgeAfter: DateTime(2026, 11, 24),
      ),
    );

    final deletion = await build().getDeletion();

    expect(deletion!.purgeAfter, DateTime(2026, 11, 24));
    expect(deletion.requestedAt, DateTime(2026, 11, 10));
  });

  test('requesting returns the purge date', () async {
    when(() => dataSource.requestDeletion()).thenAnswer(
      (_) async => MutationRequestAccountDeletioninsertDeletionRequestsOne(
        requestedAt: DateTime(2026, 11, 10),
        purgeAfter: DateTime(2026, 11, 24),
      ),
    );

    final deletion = await build().requestDeletion();

    expect(deletion.purgeAfter, DateTime(2026, 11, 24));
  });

  test('cancelling deletes the request of the signed-in person', () async {
    when(() => dataSource.cancelDeletion('u1')).thenAnswer((_) async {});

    await build().cancelDeletion();

    verify(() => dataSource.cancelDeletion('u1')).called(1);
  });
}
