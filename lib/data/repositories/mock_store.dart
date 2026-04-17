import 'package:g4_t1_velo_app/model/bicycle.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';

/// Shared in-memory state for mock repositories.
/// Acts as the single source of truth for slot data during dev/mock mode.
class MockStore {
  static final Map<String, BikeSlot> _slots = {
    'slot_cm_01': const BikeSlot(
      id: 'slot_cm_01',
      stationId: 'station_central_market',
      bike: Bicycle(id: 'bike_101', bikeNo: 'V101'),
    ),
    'slot_cm_02': const BikeSlot(
      id: 'slot_cm_02',
      stationId: 'station_central_market',
      bike: Bicycle(id: 'bike_102', bikeNo: 'V102'),
    ),
    'slot_cm_03': const BikeSlot(
      id: 'slot_cm_03',
      stationId: 'station_central_market',
    ),
    'slot_cm_04': const BikeSlot(
      id: 'slot_cm_04',
      stationId: 'station_central_market',
      bike: Bicycle(id: 'bike_104', bikeNo: 'V104'),
    ),
    'slot_cm_05': const BikeSlot(
      id: 'slot_cm_05',
      stationId: 'station_central_market',
    ),
    'slot_cm_06': const BikeSlot(
      id: 'slot_cm_06',
      stationId: 'station_central_market',
    ),
    'slot_rv_01': const BikeSlot(
      id: 'slot_rv_01',
      stationId: 'station_riverside',
      bike: Bicycle(id: 'bike_201', bikeNo: 'V201'),
    ),
    'slot_rv_02': const BikeSlot(
      id: 'slot_rv_02',
      stationId: 'station_riverside',
    ),
    'slot_rv_03': const BikeSlot(
      id: 'slot_rv_03',
      stationId: 'station_riverside',
      bike: Bicycle(id: 'bike_203', bikeNo: 'V203'),
    ),
    'slot_rv_04': const BikeSlot(
      id: 'slot_rv_04',
      stationId: 'station_riverside',
    ),
    'slot_rv_05': const BikeSlot(
      id: 'slot_rv_05',
      stationId: 'station_riverside',
      bike: Bicycle(id: 'bike_205', bikeNo: 'V205'),
    ),
  };

  static BikeSlot? getSlot(String id) => _slots[id];

  static Bicycle? getBicycle(String id) =>
      _slots.values.map((s) => s.bike).whereType<Bicycle>().where((b) => b.id == id).firstOrNull;

  static List<BikeSlot> getSlotsForStation(String stationId) =>
      _slots.values.where((s) => s.stationId == stationId).toList();

  static void reserveSlot(String slotId, String reservedBy) {
    final slot = _slots[slotId];
    if (slot == null) return;
    _slots[slotId] = BikeSlot(
      id: slot.id,
      stationId: slot.stationId,
      bike: slot.bike,
      reservedBy: reservedBy,
    );
  }
}
