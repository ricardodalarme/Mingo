import 'package:app/features/notifications/data/models/inbox_item.dart';
import 'package:app/features/notifications/data/models/notification_kind.dart';
import 'package:app/features/notifications/data/repositories/inbox_repository.dart';
import 'package:app/features/notifications/presentation/inbox/cubit/inbox_cubit.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockInboxRepository() extends Mock implements InboxRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

void main() {
  late InboxRepository inbox;
  late ProfileRepository profile;
  final items = [
    InboxItem(id: 'i1', kind: NotificationKind.cardReceived, createdAt: DateTime.utc(2026)),
  ];

  setUp(() {
    inbox = _MockInboxRepository();
    profile = _MockProfileRepository();
    when(() => inbox.getItems()).thenAnswer((_) async => items);
    when(() => inbox.markAllRead()).thenAnswer((_) async {});
    when(() => profile.getMySettings()).thenAnswer(
      (_) async => const AccountSettings(theme: AppThemeVariant.rose, partnerName: 'Luanna'),
    );
  });

  InboxCubit build() => InboxCubit(inboxRepository: inbox, profileRepository: profile);

  test('load shows the items and the partner name', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.items, Success(items));
    expect(cubit.state.partnerName, 'Luanna');
  });

  test('a failing load shows a failure that can be retried', () async {
    when(() => inbox.getItems()).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.items, isA<Failure>());
  });

  test('marking all read saves and reloads the list', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.markAllRead();

    verify(() => inbox.markAllRead()).called(1);
    verify(() => inbox.getItems()).called(2);
  });

  test('a failing mark shows the error without losing the list', () async {
    when(() => inbox.markAllRead()).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.markAllRead();

    expect(cubit.state.items, Success(items));
    expect(cubit.state.markAction, isA<Initial>());
  });
}
