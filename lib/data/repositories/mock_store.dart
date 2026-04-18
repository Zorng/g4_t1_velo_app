import 'package:g4_t1_velo_app/model/bicycle.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/location.dart';
import 'package:g4_t1_velo_app/model/station.dart';

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

  static final List<_StationSeed> _stationSeeds = [
    _StationSeed(
      id: 'station_central_market',
      name: 'Central Market',
      totalSlot: 6,
      location: Location(
        id: 'location_central_market',
        latitude: 11.5696,
        longitude: 104.916,
        address: 'Central Market, Phnom Penh',
      ),
    ),
    _StationSeed(
      id: 'station_riverside',
      name: 'Riverside',
      totalSlot: 5,
      location: Location(
        id: 'location_riverside',
        latitude: 11.5731,
        longitude: 104.9282,
        address: 'Sisowath Quay, Phnom Penh',
      ),
    ),
  ];

  static List<Station> get stations => _stationSeeds.map(_buildStation).toList();

  static BikeSlot? getSlot(String id) => _slots[id];

  static Station? getStation(String id) {
    final seed = _stationSeeds.where((station) => station.id == id).firstOrNull;
    return seed == null ? null : _buildStation(seed);
  }

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

  static Station _buildStation(_StationSeed seed) => Station(
    id: seed.id,
    name: seed.name,
    totalSlot: seed.totalSlot,
    location: seed.location,
    slots: getSlotsForStation(seed.id),
  );
}

class _StationSeed {
  const _StationSeed({
    required this.id,
    required this.name,
    required this.totalSlot,
    required this.location,
  });

  final String id;
  final String name;
  final int totalSlot;
  final Location location;
}
