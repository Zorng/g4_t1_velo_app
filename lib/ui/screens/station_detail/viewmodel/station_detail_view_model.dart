import 'package:flutter/foundation.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/utils/async_value.dart';

class StationDetailViewModel extends ChangeNotifier {
  StationDetailViewModel({
    required StationRepository stationRepository,
    required this.stationId,
  }) : _stationRepository = stationRepository;

  final StationRepository _stationRepository;
  final String stationId;

  AsyncValue<Station> _stationState = AsyncValue.loading();

  AsyncValue<Station> get stationState => _stationState;
  
  Station? get station => _stationState.data;

  int get availableBikeCount => station?.getAvailableSlots().length ?? 0;

  int get emptySlotCount =>
      station?.slots.where((s) => s.status == SlotStatus.empty).length ?? 0;

  Future<void> load() async {
    _stationState = AsyncValue.loading();
    notifyListeners();

    try {
      final station = await _stationRepository.getStationById(stationId);
      if (station == null) {
        _stationState = AsyncValue.error('Station not found.');
      } else {
        _stationState = AsyncValue.success(station);
      }
    } catch (error) {
      _stationState = AsyncValue.error(error);
    }

    notifyListeners();
  }
}
