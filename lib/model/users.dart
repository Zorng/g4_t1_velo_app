import 'package:g4_t1_velo_app/model/booking.dart';
import 'package:g4_t1_velo_app/model/pass.dart';

class Users {
  const Users({
    required this.id,
    this.activePass,
    this.currentBooking,
  });

  final String id;
  final Pass? activePass;
  final Booking? currentBooking;
}
