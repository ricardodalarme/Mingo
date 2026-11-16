import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/games/data/mappers/game_enum_mapper.dart';
import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps the games the app has screens for', () {
    expect(EnumGameKind_enum.me_or_you.toModel(), GameKind.meOrYou);
    expect(EnumGameKind_enum.how_well.toModel(), GameKind.howWell);
    expect(EnumGameKind_enum.twenty_questions.toModel(), GameKind.twentyQuestions);
    expect(EnumGameKind_enum.never_have_we.toModel(), GameKind.neverHaveWe);
    expect(EnumGameKind_enum.mission.toModel(), GameKind.mission);
  });

  test('a game without screens is left out', () {
    expect(EnumGameKind_enum.compliments.toModel(), isNull);
    expect(EnumGameKind_enum.$unknown.toModel(), isNull);
  });

  test('a game survives a trip to the remote enum and back', () {
    for (final value in GameKind.values) {
      expect(value.toRemote().toModel(), value);
    }
  });

  test('maps every status and counts an unknown one as cancelled', () {
    expect(EnumGameStatus_enum.invited.toModel(), GameStatus.invited);
    expect(EnumGameStatus_enum.active.toModel(), GameStatus.active);
    expect(EnumGameStatus_enum.finished.toModel(), GameStatus.finished);
    expect(EnumGameStatus_enum.cancelled.toModel(), GameStatus.cancelled);
    expect(EnumGameStatus_enum.$unknown.toModel(), GameStatus.cancelled);
  });
}
