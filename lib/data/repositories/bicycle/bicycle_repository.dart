import 'package:g4_t1_velo_app/model/bicycle.dart';

abstract class BicycleRepository {
  Future<Bicycle> getBicycle(String id);
}
