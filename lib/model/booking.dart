import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:g4_t1_velo_app/model/users.dart';

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
}

class Booking {
  const Booking({
    required this.id,
    required this.user,
    required this.slot,
    required this.pass,
    required this.start,
    this.end,
    this.status = BookingStatus.pending,
  });

  final String id;
  final Users user;
  final BikeSlot slot;
  final Pass pass;
  final DateTime start;
  final DateTime? end;
  final BookingStatus status;
}
