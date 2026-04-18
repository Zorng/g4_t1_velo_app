import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/mock_store.dart';
import 'package:g4_t1_velo_app/model/booking.dart';

class BookingRepositoryMock implements BookingRepository {
  final List<Booking> _bookings = [];

  @override
  Future<Booking> createBooking(Booking booking) async {
    final created = Booking(
      id: 'b_mock_${_bookings.length + 1}',
      user: booking.user,
      slot: booking.slot,
      pass: booking.pass,
      start: booking.start,
      status: BookingStatus.confirmed,
    );
    _bookings.add(created);
    MockStore.reserveSlot(booking.slot.id, booking.user.id);
    return created;
  }
}
