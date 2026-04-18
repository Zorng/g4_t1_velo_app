import 'package:g4_t1_velo_app/model/booking.dart';

abstract class BookingRepository {
  Future<Booking> createBooking(Booking booking);
}
