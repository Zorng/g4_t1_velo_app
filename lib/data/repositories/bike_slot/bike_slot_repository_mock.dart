import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/mock_store.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';

class BikeSlotRepositoryMock implements BikeSlotRepository {
  @override
  Future<BikeSlot> getSlot(String slotId) async {
    final slot = MockStore.getSlot(slotId);
    if (slot == null) throw Exception('Slot $slotId not found');
    return slot;
  }
}
