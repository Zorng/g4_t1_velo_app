import 'package:g4_t1_velo_app/model/bicycle.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/location.dart';
import 'package:g4_t1_velo_app/model/station.dart';

import 'station_repository.dart';

class MockStationRepository implements StationRepository {
  MockStationRepository();

  static const _mockDelay = Duration(milliseconds: 350);

  final List<Station> _stations = [
    Station(
      id: 'station_central_market',
      name: 'Central Market',
      location: Location(
        id: 'location_central_market',
        longitude: 104.916,
        latitude: 11.5696,
        address: 'Central Market, Phnom Penh',
      ),
      totalSlot: 6,
      slots: const [
        BikeSlot(
          id: 'slot_cm_01',
          stationId: 'station_central_market',
          bike: Bicycle(id: 'bike_101', bikeNo: 'V101'),
        ),
        BikeSlot(
          id: 'slot_cm_02',
          stationId: 'station_central_market',
          bike: Bicycle(id: 'bike_102', bikeNo: 'V102'),
        ),
        BikeSlot(id: 'slot_cm_03', stationId: 'station_central_market'),
        BikeSlot(
          id: 'slot_cm_04',
          stationId: 'station_central_market',
          bike: Bicycle(id: 'bike_104', bikeNo: 'V104'),
        ),
        BikeSlot(id: 'slot_cm_05', stationId: 'station_central_market'),
        BikeSlot(id: 'slot_cm_06', stationId: 'station_central_market'),
      ],
    ),
    Station(
      id: 'station_riverside',
      name: 'Riverside',
      location: Location(
        id: 'location_riverside',
        longitude: 104.9282,
        latitude: 11.5731,
        address: 'Sisowath Quay, Phnom Penh',
      ),
      totalSlot: 5,
      slots: const [
        BikeSlot(
          id: 'slot_rv_01',
          stationId: 'station_riverside',
          bike: Bicycle(id: 'bike_201', bikeNo: 'V201'),
        ),
        BikeSlot(id: 'slot_rv_02', stationId: 'station_riverside'),
        BikeSlot(
          id: 'slot_rv_03',
          stationId: 'station_riverside',
          bike: Bicycle(id: 'bike_203', bikeNo: 'V203'),
        ),
        BikeSlot(id: 'slot_rv_04', stationId: 'station_riverside'),
        BikeSlot(
          id: 'slot_rv_05',
          stationId: 'station_riverside',
          bike: Bicycle(id: 'bike_205', bikeNo: 'V205'),
        ),
      ],
    ),
  ];

  @override
  Future<List<Station>> getStations() async {
    await Future<void>.delayed(_mockDelay);
    return List<Station>.unmodifiable(_stations);
  }

  @override
  Future<Station?> getStationById(String id) async {
    await Future<void>.delayed(_mockDelay);

    for (final station in _stations) {
      if (station.id == id) {
        return station;
      }
    }

    return null;
  }
}
