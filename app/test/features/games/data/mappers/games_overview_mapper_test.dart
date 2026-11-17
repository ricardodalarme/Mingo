import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/games_data_source.dart';
import 'package:app/features/games/data/mappers/games_overview_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  GameSessionRecord session(String id, EnumGameKind_enum game) => (
    id: id,
    game: game,
    status: EnumGameStatus_enum.active,
    invitedBy: 'me',
    itemSlugs: const [],
    createdAt: DateTime.utc(2026),
  );

  test('copies the person, the partner and whether there is a couple', () {
    final overview = (
      selfId: 'me',
      hasCouple: true,
      partnerName: 'Rui',
      sessions: const <GameSessionRecord>[],
    ).toModel();

    expect(overview.selfId, 'me');
    expect(overview.hasPartner, isTrue);
    expect(overview.partnerName, 'Rui');
    expect(overview.sessions, isEmpty);
  });

  test('leaves out the sessions of games the app has no screens for', () {
    final overview = (
      selfId: 'me',
      hasCouple: true,
      partnerName: null,
      sessions: [
        session('a', EnumGameKind_enum.me_or_you),
        session('b', EnumGameKind_enum.compliments),
      ],
    ).toModel();

    expect(overview.sessions.map((session) => session.id), ['a']);
  });

  test('a person without a couple has no partner', () {
    final overview = (
      selfId: 'me',
      hasCouple: false,
      partnerName: null,
      sessions: const <GameSessionRecord>[],
    ).toModel();

    expect(overview.hasPartner, isFalse);
  });
}
