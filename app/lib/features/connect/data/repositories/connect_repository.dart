import 'package:app/features/_shared/data/models/content_kind.dart';
import 'package:app/features/connect/data/data_sources/remote/connect_data_source.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/together/data/models/date_idea.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';

class ConnectRepository({
  required final ConnectDataSource _dataSource,
  required final TogetherRepository _togetherRepository,
  required final ProfileRepository _profileRepository,
}) {
  /// Sends the light "I miss us" signal to the partner.
  Future<void> sendMissUs() async {
    await _dataSource.sendMissUs();
  }

  /// Whether touch topics are on for both; true when the person has no couple, since nothing is shared.
  Future<bool> getTouchTopicsEnabled() async {
    final settings = await _profileRepository.getMySettings();
    final couple = await _dataSource.getTouchSetting(settings.profileId);

    return couple?.touchTopicsEnabled ?? true;
  }

  Future<void> setTouchTopicsEnabled({required bool enabled}) async {
    final settings = await _profileRepository.getMySettings();
    final couple = await _dataSource.getTouchSetting(settings.profileId);
    if (couple == null) return;

    await _dataSource.setTouchTopics(coupleId: couple.coupleId, enabled: enabled);
  }

  /// The neutral touch cards in the person's language, in editorial order.
  Future<List<HelpItem>> getTouchCards() async {
    final settings = await _profileRepository.getMySettings();

    return _togetherRepository.getHelpContent(kind: ContentKind.touchCard, locale: settings.locale);
  }
}
