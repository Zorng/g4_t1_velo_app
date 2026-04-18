import 'dart:convert';

import 'package:g4_t1_velo_app/data/dto/bike_slot_dto.dart';
import 'package:g4_t1_velo_app/data/dto/booking_dto.dart';
import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository.dart';
import 'package:g4_t1_velo_app/model/booking.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class BookingRepositoryFirebase implements BookingRepository {
  final String baseUrl = 'velocambodia-fbeee-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<Booking> createBooking(Booking booking) async {
    final bookingId = const Uuid().v4();

    final response = await http.patch(
      Uri.https(baseUrl, '/.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'bookings/$bookingId': {
          BookingDto.userIdKey: booking.user.id,
          BookingDto.slotIdKey: booking.slot.id,
          BookingDto.passIdKey: booking.pass.id,
          BookingDto.startKey: booking.start.toIso8601String(),
          BookingDto.endKey: null,
          BookingDto.statusKey: BookingStatus.confirmed.name,
        },
        'slots/${booking.slot.id}/${BikeSlotDto.reservedByKey}': booking.user.id,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create booking: ${response.statusCode}');
    }

    return Booking(
      id: bookingId,
      user: booking.user,
      slot: booking.slot,
      pass: booking.pass,
      start: booking.start,
      status: BookingStatus.confirmed,
    );
  }
}
