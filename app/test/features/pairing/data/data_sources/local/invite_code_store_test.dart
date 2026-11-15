import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preferences_service/preferences_service.dart';

class _MockPreferencesService() extends Mock implements PreferencesService;

void main() {
  late PreferencesService preferences;
  late InviteCodeStore store;

  setUp(() {
    preferences = _MockPreferencesService();
    store = InviteCodeStore(preferencesService: preferences);
  });

  test('reads the kept code', () {
    when(() => preferences.readString(key: 'pendingInviteCode')).thenReturn('ABCD2345');

    expect(store.read(), 'ABCD2345');
  });

  test('writes and deletes the kept code', () async {
    when(() => preferences.writeString(key: 'pendingInviteCode', value: 'ABCD2345'))
        .thenAnswer((_) async {});
    when(() => preferences.delete(key: 'pendingInviteCode')).thenAnswer((_) async {});

    await store.save('ABCD2345');
    await store.clear();

    verifyInOrder([
      () => preferences.writeString(key: 'pendingInviteCode', value: 'ABCD2345'),
      () => preferences.delete(key: 'pendingInviteCode'),
    ]);
  });

  test('clearing ignores unavailable device storage', () async {
    when(() => preferences.delete(key: 'pendingInviteCode')).thenThrow(Exception());

    await store.clear();
  });
}
