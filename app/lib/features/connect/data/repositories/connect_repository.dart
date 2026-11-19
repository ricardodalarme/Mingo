import 'package:app/features/connect/data/data_sources/remote/connect_data_source.dart';

class ConnectRepository({required final ConnectDataSource _dataSource}) {
  /// Sends the light "I miss us" signal to the partner.
  Future<void> sendMissUs() async {
    await _dataSource.sendMissUs();
  }
}
