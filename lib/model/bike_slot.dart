import 'package:g4_t1_velo_app/model/bicycle.dart';

enum SlotStatus {
  available,
  empty,
}

class BikeSlot {
  const BikeSlot({
    required this.id,
    required this.stationId,
    this.bike,
  });

  final String id;
  final String stationId;
  final Bicycle? bike;

  SlotStatus get status => bike == null ? SlotStatus.empty : SlotStatus.available;
}
