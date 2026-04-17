import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:latlong2/latlong.dart';

class MapScreenVm with ChangeNotifier {
  MapScreenVm({required StationRepository stationRepository})
    : _stationRepository = stationRepository;

  static const LatLng initialCenter = LatLng(11.5686, 104.9265);
  static const double initialZoom = 14;

  final StationRepository _stationRepository;

  List<Station> _stations = const [];
  bool _isLoading = false;
  Object? _error;

  List<Station> get stations => _stations;
  bool get isLoading => _isLoading;
  Object? get error => _error;

  Future<void> loadStations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _stations = await _stationRepository.getAllStations();
    } catch (error) {
      _error = error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
