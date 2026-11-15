import 'package:app/features/pairing/data/mappers/invite_code_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reads the code from the custom scheme path', () {
    expect(inviteCodeFromUri(Uri.parse('mingo://invite/abcd2345')), 'ABCD2345');
  });

  test('reads the code from the custom scheme query', () {
    expect(inviteCodeFromUri(Uri.parse('mingo://invite?code=abcd2345')), 'ABCD2345');
  });

  test('reads the code from an https path and query', () {
    expect(inviteCodeFromUri(Uri.parse('https://mingo.app/invite/abcd2345')), 'ABCD2345');
    expect(inviteCodeFromUri(Uri.parse('https://mingo.app/invite?code=abcd2345')), 'ABCD2345');
  });

  test('ignores a trailing slash and surrounding spaces', () {
    expect(inviteCodeFromUri(Uri.parse('mingo://invite/abcd2345/')), 'ABCD2345');
    expect(inviteCodeFromUri(Uri.parse('mingo://invite/%20abcd2345%20')), 'ABCD2345');
  });

  test('a link without an invite target or code has no code', () {
    expect(inviteCodeFromUri(Uri.parse('mingo://today?homeWidget=1')), isNull);
    expect(inviteCodeFromUri(Uri.parse('mingo://invite')), isNull);
    expect(inviteCodeFromUri(Uri.parse('https://mingo.app/invite?code=')), isNull);
  });
}
