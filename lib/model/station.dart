import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/location.dart';

class Station {
  const Station({
    required this.id,
    required this.name,
    required this.location,
    required this.totalSlot,
    required this.slots,
  });

  final String id;
  final String name;
  final Location location;
  final int totalSlot;
  final List<BikeSlot> slots;

  List<BikeSlot> getAvailableSlots() {
    return slots
        .where((slot) => slot.status == SlotStatus.available)
        .toList(growable: false);
  }
}
