import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:core/core.dart';

class CoupleInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector.registerFactory<CoupleCubit>(
    () => CoupleCubit(historyRepository: injector.get<HistoryRepository>()),
  );
}
