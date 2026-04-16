import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository.dart';
import 'package:g4_t1_velo_app/model/pass.dart';

class PassRepositoryFirebase implements PassRepository {
  @override
  Future<List<Pass>> getPasses() async {
    // TODO: fetch passes from Firestore
    throw UnimplementedError('PassRepositoryFirebase.getPasses');
  }
}
