import 'package:app/features/memories/data/models/memory.dart';
import 'package:app/features/memories/data/repositories/memories_repository.dart';
import 'package:clock/clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnThisDayCubit({required final MemoriesRepository _memoriesRepository})
    extends Cubit<List<Memory>> {
  this : super(const []);

  /// Looks for memories from this day in earlier years; no match, or a failed read, shows nothing.
  Future<void> load() async {
    try {
      emit(memoriesOnThisDay(await _memoriesRepository.getMemories(), today: clock.now()));
    } on Object {
      emit(const []);
    }
  }
}
