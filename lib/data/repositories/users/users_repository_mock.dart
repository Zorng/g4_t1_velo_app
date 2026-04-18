import 'package:g4_t1_velo_app/data/repositories/users/users_repository.dart';
import 'package:g4_t1_velo_app/model/pass.dart';

class UsersRepositoryMock implements UsersRepository {
  Pass? _activePass;
  String? _currentBookingId;

  @override
  Future<Pass?> getActivePass(String userId) async => _activePass;

  @override
  Future<void> updateActivePass(String userId, Pass pass) async {
    _activePass = pass;
  }

  @override
  Future<String?> getCurrentBookingId(String userId) async => _currentBookingId;

  @override
  Future<void> updateCurrentBookingId(String userId, String bookingId) async {
    _currentBookingId = bookingId;
  }
}
