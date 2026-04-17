import 'package:g4_t1_velo_app/model/bicycle.dart';

enum SlotStatus {
  available,
  reserved,
  empty,
}

class BikeSlot {
  const BikeSlot({
    required this.id,
    required this.stationId,
    this.bike,
    this.reservedBy,
  });

  final String id;
  final String stationId;
  final Bicycle? bike;
  final String? reservedBy; // user ID of who booked this bike

  SlotStatus get status {
    if (bike == null) return SlotStatus.empty;
    if (reservedBy != null) return SlotStatus.reserved;
    return SlotStatus.available;
  }

  bool isBookedByUser(String userId) => reservedBy == userId;
}
