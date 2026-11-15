import 'package:app/features/share/data/repositories/share_image_repository.dart';
import 'package:core/core.dart';
import 'package:share_service/share_service.dart';

class ShareInjectionModule() implements InjectionModule {
  @override
  void registerDependencies({required Injector injector}) => injector
    ..registerLazySingleton<ShareImageRepository>(
      () => ShareImageRepository(shareService: injector.get<ShareService>()),
    );
}
