import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/privacy/data/data_sources/remote/privacy_data_source.dart';
import 'package:app/features/privacy/data/data_sources/remote/queries/generated/MyConsents.graphql.dart';
import 'package:app/features/privacy/data/models/consent.dart';
import 'package:app/features/privacy/data/repositories/privacy_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockPrivacyDataSource() extends Mock implements PrivacyDataSource;

QueryMyConsentsconsents _row(EnumConsentKind_enum kind, bool granted, {DateTime? at}) =>
    QueryMyConsentsconsents(
      kind: kind,
      granted: granted,
      version: '1',
      createdAt: at ?? DateTime(2026, 11, 10),
    );

void main() {
  late PrivacyDataSource dataSource;

  setUpAll(() => registerFallbackValue(EnumConsentKind_enum.analytics));

  setUp(() => dataSource = _MockPrivacyDataSource());

  PrivacyRepository build() => PrivacyRepository(dataSource: dataSource);

  test('the newest row per kind wins and missing kinds use the defaults', () async {
    when(() => dataSource.getConsents()).thenAnswer(
      (_) async => [
        _row(EnumConsentKind_enum.analytics, false, at: DateTime(2026, 11, 10)),
        _row(EnumConsentKind_enum.analytics, true, at: DateTime(2026, 11, 9)),
        _row(EnumConsentKind_enum.marketing, true),
      ],
    );

    final consents = await build().getConsents();

    expect(consents[ConsentKind.analytics], isFalse);
    expect(consents[ConsentKind.marketing], isTrue);
    expect(consents[ConsentKind.terms], isTrue);
    expect(consents[ConsentKind.ai], isFalse);
  });

  test('a withdrawal is recorded with the current version', () async {
    when(
      () => dataSource.grant(
        kind: any(named: 'kind'),
        granted: any(named: 'granted'),
        version: any(named: 'version'),
      ),
    ).thenAnswer((_) async {
      return;
    });

    await build().setConsent(ConsentKind.marketing, granted: false);

    verify(
      () => dataSource.grant(
        kind: EnumConsentKind_enum.marketing,
        granted: false,
        version: PrivacyRepository.consentVersion,
      ),
    ).called(1);
  });
}
