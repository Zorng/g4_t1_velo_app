import 'package:flutter/foundation.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/utils/async_value.dart';

class MapScreenViewModel extends ChangeNotifier {
  MapScreenViewModel({
    required StationRepository stationRepository,
  }) : _stationRepository = stationRepository;

  final StationRepository _stationRepository;

  AsyncValue<List<Station>> _stationState = AsyncValue.loading();

  AsyncValue<List<Station>> get stationState => _stationState;

  List<Station> get stations => _stationState.data ?? const [];

  List<Station> searchStations(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return const [];
    }

    return stations.where((station) {
      return station.name.toLowerCase().contains(normalizedQuery) ||
          station.location.address.toLowerCase().contains(normalizedQuery);
    }).toList(growable: false);
  }

  Future<void> load() async {
    _stationState = AsyncValue.loading();
    notifyListeners();

    try {
      final stations = await _stationRepository.getStations();
      _stationState = AsyncValue.success(stations);
    } catch (error) {
      _stationState = AsyncValue.error(error);
    }

    notifyListeners();
  }
}
