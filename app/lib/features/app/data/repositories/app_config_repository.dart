import 'package:app/features/app/data/data_sources/remote/app_config_data_source.dart';

class AppConfigRepository({required final AppConfigDataSource _dataSource}) {
  Future<String?> getMinAppVersion() async {
    return await _dataSource.getMinAppVersion();
  }
}
