import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/plus/data/data_sources/remote/plus_data_source.dart';
import 'package:app/features/plus/data/data_sources/remote/queries/generated/MyPlus.graphql.dart';
import 'package:app/features/plus/data/models/plus_plan.dart';
import 'package:app/features/plus/data/models/plus_state.dart';
import 'package:app/features/plus/data/models/plus_status.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:purchase_service/purchase_service.dart';

class _MockPlusDataSource() extends Mock implements PlusDataSource;

class _MockPurchaseService() extends Mock implements PurchaseService;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

CustomerInfo _customerInfo({bool active = false}) => CustomerInfo.fromJson({
  'entitlements': const {'all': <String, dynamic>{}, 'active': <String, dynamic>{}},
  'allPurchaseDates': const <String, dynamic>{},
  'activeSubscriptions': active ? const ['plus_monthly'] : const <String>[],
  'allPurchasedProductIdentifiers': const <String>[],
  'nonSubscriptionTransactions': const <String>[],
  'firstSeen': '',
  'originalAppUserId': '',
  'allExpirationDates': const <String, dynamic>{},
  'requestDate': '',
});

void main() {
  late PlusDataSource dataSource;
  late PurchaseService purchaseService;
  late AuthenticationRepository authenticationRepository;

  setUp(() {
    dataSource = _MockPlusDataSource();
    purchaseService = _MockPurchaseService();
    authenticationRepository = _MockAuthenticationRepository();
    when(() => authenticationRepository.currentUserId).thenReturn('u1');
  });

  PlusRepository build({
    Duration window = const Duration(seconds: 1),
    Duration step = const Duration(milliseconds: 1),
  }) => PlusRepository(
    dataSource: dataSource,
    purchaseService: purchaseService,
    authenticationRepository: authenticationRepository,
    confirmationWindow: window,
    confirmationStep: step,
  );

  test('myPlus maps the plan, status and monthly room', () async {
    when(() => dataSource.getPlus('u1')).thenAnswer(
      (_) async => QueryMyPlusplusStates(
        hasPlus: true,
        paidByPartner: true,
        slipsLeftThisMonth: 2,
        cardsLeftThisMonth: 1,
        entitlement: QueryMyPlusplusStatesentitlement(
          plan: EnumEntitlementPlan_enum.plus_annual,
          status: EnumEntitlementStatus_enum.active,
        ),
      ),
    );

    final plus = await build().getPlus();

    expect(plus.hasPlus, isTrue);
    expect(plus.isPaidByPartner, isTrue);
    expect(plus.plan, PlusPlan.annual);
    expect(plus.status, PlusStatus.active);
    expect(plus.slipsLeft, 2);
    expect(plus.cardsLeft, 1);
  });

  test('a restore that the server confirms unlocks Plus', () async {
    when(() => purchaseService.restorePurchases())
        .thenAnswer((_) async => _customerInfo(active: true));
    var reads = 0;
    when(() => dataSource.getPlus(any()))
        .thenAnswer((_) async => QueryMyPlusplusStates(hasPlus: reads++ > 0));

    expect(await build().restorePurchases(), RestoreOutcome.unlocked);
    verify(() => purchaseService.restorePurchases()).called(1);
    verify(() => dataSource.getPlus('u1')).called(2);
  });

  test('a store with nothing to restore ends without a Plus read', () async {
    when(() => purchaseService.restorePurchases()).thenAnswer((_) async => _customerInfo());

    final outcome = await build(window: const Duration(seconds: 30)).restorePurchases();

    expect(outcome, RestoreOutcome.nothing);
    verifyNever(() => dataSource.getPlus(any()));
  });

  test('a store purchase the server has not confirmed stays pending', () async {
    when(() => purchaseService.restorePurchases())
        .thenAnswer((_) async => _customerInfo(active: true));
    when(() => dataSource.getPlus(any()))
        .thenAnswer((_) async => QueryMyPlusplusStates(hasPlus: false));

    final outcome = await build(
      window: const Duration(milliseconds: 1),
      step: const Duration(milliseconds: 1),
    ).restorePurchases();

    expect(outcome, RestoreOutcome.pending);
  });

  test('a restore without a store key is a calm localized failure', () async {
    when(() => purchaseService.restorePurchases()).thenThrow(const PurchaseUnavailableException());

    await expectLater(
      build().restorePurchases(),
      throwsA(
        isA<LocalizedException>().having(
          (exception) => exception.l10nKey,
          'l10nKey',
          'storeUnavailable',
        ),
      ),
    );
  });

  test('the store management page is read as a Uri', () async {
    final url = Uri.parse('https://apps.apple.com/account/subscriptions');
    when(() => purchaseService.getManagementUrl()).thenAnswer((_) async => url);

    expect(await build().getManagementUrl(), url);
  });

  test('a missing store management page stays null', () async {
    when(() => purchaseService.getManagementUrl()).thenAnswer((_) async => null);

    expect(await build().getManagementUrl(), isNull);
  });

  test('an unconfigured store maps to the storeUnavailable failure', () async {
    when(() => purchaseService.getManagementUrl()).thenThrow(const PurchaseUnavailableException());

    await expectLater(
      build().getManagementUrl(),
      throwsA(
        isA<LocalizedException>().having(
          (exception) => exception.l10nKey,
          'l10nKey',
          'storeUnavailable',
        ),
      ),
    );
  });
}
