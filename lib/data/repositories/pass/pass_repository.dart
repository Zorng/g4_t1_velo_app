import 'package:g4_t1_velo_app/model/pass.dart';

abstract class PassRepository {
  Future<List<Pass>> getPasses();
}
