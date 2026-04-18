import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:g4_t1_velo_app/data/services/bike_slot_service.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';

class BikeSlotRepositoryFirebase implements BikeSlotRepository {
  const BikeSlotRepositoryFirebase({required BikeSlotService bikeSlotService})
      : _service = bikeSlotService;

  final BikeSlotService _service;

  @override
  Future<BikeSlot> getSlot(String slotId) => _service.fetchSlot(slotId);
}
