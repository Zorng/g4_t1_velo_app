import 'package:g4_t1_velo_app/model/bicycle.dart';
import 'package:g4_t1_velo_app/model/station.dart';

enum SlotStatus {
  available,
  empty,
}

class BikeSlot {
  const BikeSlot({
    required this.id,
    required this.station,
    this.bike,
  });

  final String id;
  final Station station;
  final Bicycle? bike;

  SlotStatus get status => bike == null ? SlotStatus.empty : SlotStatus.available;
}
