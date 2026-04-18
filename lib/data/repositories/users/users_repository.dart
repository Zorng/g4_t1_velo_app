import 'package:g4_t1_velo_app/model/pass.dart';

abstract class UsersRepository {
  Future<Pass?> getActivePass(String userId);
  Future<void> updateActivePass(String userId, Pass pass);
  Future<String?> getCurrentBookingId(String userId);
  Future<void> updateCurrentBookingId(String userId, String bookingId);
}
