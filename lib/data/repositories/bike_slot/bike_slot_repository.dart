import 'package:g4_t1_velo_app/model/bike_slot.dart';

abstract class BikeSlotRepository {
  Future<BikeSlot> getSlot(String slotId);
}
