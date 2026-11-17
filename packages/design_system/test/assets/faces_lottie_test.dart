import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:design_system/src/components/faces/face_state_machine_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const kinds = ['good', 'affectionate', 'tired', 'tense', 'sad', 'thinking', 'smile'];
  const frames = {'in': 36, 'idle': 150, 'pop': 24};
  final archive = ZipDecoder().decodeBytes(File('assets/faces.lottie').readAsBytesSync());

  Map<String, dynamic> read(String name) {
    final file = archive.findFile(name)!;

    return jsonDecode(utf8.decode(file.content as List<int>)) as Map<String, dynamic>;
  }

  test('lists 21 animations and one state machine per kind', () {
    final manifest = read('manifest.json');

    expect((manifest['animations'] as List).length, 21);
    expect([
      for (final machine in manifest['stateMachines'] as List) (machine as Map)['id'],
    ], kinds);
  });

  for (final kind in kinds) {
    test('$kind animations are 32 point drawings with the right length', () {
      for (final entry in frames.entries) {
        final animation = read('a/${kind}_${entry.key}.json');

        expect(animation['op'], entry.value, reason: entry.key);
        expect(animation['w'], 32);
        expect((animation['slots'] as Map).containsKey('ink'), isTrue);
      }
    });

    test('$kind machine has the four states and starts idle', () {
      final machine = read('s/$kind.json');
      final states = {
        for (final state in machine['states'] as List) (state as Map)['name'] as String: state,
      };

      expect(states.keys, containsAll(['in', 'idle', 'pop', 'still']));
      expect(machine['initial'], 'idle');
      for (final state in states.values) {
        expect(archive.findFile('a/${state['animation']}.json'), isNotNull);
      }
    });
  }

  test('the source resolves to the package asset key', () {
    expect('assets/$faceAnimationSource', 'assets/../packages/design_system/assets/faces.lottie');
    expect(File('assets/faces.lottie').existsSync(), isTrue);
  });
}
