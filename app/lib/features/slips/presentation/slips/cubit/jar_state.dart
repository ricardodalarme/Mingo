part of 'jar_cubit.dart';

final class const JarState({final Resource<DrawnSlip?> slip = const Loading()}) with Equatable {
  JarState copyWith({Resource<DrawnSlip?>? slip}) => JarState(slip: slip ?? this.slip);

  @override
  List<Object?> get props => [slip];
}
