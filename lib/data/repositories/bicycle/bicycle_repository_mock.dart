import 'package:g4_t1_velo_app/data/repositories/bicycle/bicycle_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/mock_store.dart';
import 'package:g4_t1_velo_app/model/bicycle.dart';

class BicycleRepositoryMock implements BicycleRepository {
  @override
  Future<Bicycle> getBicycle(String id) async {
    final bike = MockStore.getBicycle(id);
    if (bike == null) throw Exception('Bicycle $id not found');
    return bike;
  }
}
