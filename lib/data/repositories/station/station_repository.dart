import 'package:g4_t1_velo_app/model/station.dart';

abstract class StationRepository {
  Future<List<Station>> getStations();

  Future<Station?> getStationById(String id);
}
