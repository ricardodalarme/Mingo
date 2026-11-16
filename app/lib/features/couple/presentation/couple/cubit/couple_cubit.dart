import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'couple_state.dart';

class CoupleCubit() extends Cubit<CoupleState> {
  this : super(const CoupleState());

  /// Opens one of the two parts of Nós.
  void select(CoupleSection section) => emit(CoupleState(section: section));
}
