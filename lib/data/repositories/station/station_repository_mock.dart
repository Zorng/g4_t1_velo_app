import 'package:g4_t1_velo_app/data/repositories/mock_store.dart';
import 'package:g4_t1_velo_app/model/location.dart';
import 'package:g4_t1_velo_app/model/station.dart';

import 'station_repository.dart';

class MockStationRepository implements StationRepository {
  static const _mockDelay = Duration(milliseconds: 350);

  Station _buildCentralMarket() => Station(
        id: 'station_central_market',
        name: 'Central Market',
        totalSlot: 6,
        location: Location(
          id: 'location_central_market',
          latitude: 11.5696,
          longitude: 104.916,
          address: 'Central Market, Phnom Penh',
        ),
        slots: MockStore.getSlotsForStation('station_central_market'),
      );

  Station _buildRiverside() => Station(
        id: 'station_riverside',
        name: 'Riverside',
        totalSlot: 5,
        location: Location(
          id: 'location_riverside',
          latitude: 11.5731,
          longitude: 104.9282,
          address: 'Sisowath Quay, Phnom Penh',
        ),
        slots: MockStore.getSlotsForStation('station_riverside'),
      );

  @override
  Future<List<Station>> getStations() async {
    await Future<void>.delayed(_mockDelay);
    return [_buildCentralMarket(), _buildRiverside()];
  }

  @override
  Future<Station?> getStationById(String id) async {
    await Future<void>.delayed(_mockDelay);
    return switch (id) {
      'station_central_market' => _buildCentralMarket(),
      'station_riverside' => _buildRiverside(),
      _ => null,
    };
  }
}
