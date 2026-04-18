import 'package:g4_t1_velo_app/data/repositories/mock_store.dart';
import 'package:g4_t1_velo_app/model/station.dart';

import 'station_repository.dart';

class MockStationRepository implements StationRepository {
  static const _mockDelay = Duration(milliseconds: 350);

  @override
  Future<List<Station>> getStations() async {
    await Future<void>.delayed(_mockDelay);
    return MockStore.stations;
  }

  @override
  Future<Station?> getStationById(String id) async {
    await Future<void>.delayed(_mockDelay);
    return MockStore.getStation(id);
  }
}
