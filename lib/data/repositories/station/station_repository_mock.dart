import 'package:g4_t1_velo_app/data/mock/data.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:g4_t1_velo_app/model/station.dart';

class StationRepositoryMock implements StationRepository {
  @override
  Future<List<Station>> getAllStations() {
    return Future.value(MockData.instance.stations);
  }
}

