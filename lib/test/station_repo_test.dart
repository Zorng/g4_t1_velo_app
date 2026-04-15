import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository_mock.dart';

void main() async {
  StationRepository repo = StationRepositoryMock();

  final res = await repo.getAllStations();

  for (var v in res) {
    print(v.name);
  }
}
