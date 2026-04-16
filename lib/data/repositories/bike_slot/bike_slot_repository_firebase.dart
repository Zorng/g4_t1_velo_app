import 'dart:convert';

import 'package:g4_t1_velo_app/data/dto/bicycle_dto.dart';
import 'package:g4_t1_velo_app/data/dto/bike_slot_dto.dart';
import 'package:g4_t1_velo_app/data/dto/station_dto.dart';
import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:g4_t1_velo_app/model/bicycle.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:http/http.dart' as http;

class BikeSlotRepositoryFirebase implements BikeSlotRepository {
  final String baseUrl = 'velocambodia-fbeee-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<BikeSlot> getSlot(String slotId) async {
    final response = await http.get(Uri.https(baseUrl, '/slots/$slotId.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load slot $slotId');
    }

    final dto = BikeSlotDto.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );

    final stationFuture = _fetchStation(dto.stationId);
    final bikeFuture =
        dto.bikeId != null ? _fetchBicycle(dto.bikeId!) : Future<Bicycle?>.value(null);
    final station = await stationFuture;
    final bike = await bikeFuture;

    return BikeSlot(
      id: slotId,
      station: station,
      bike: bike,
      reservedBy: dto.reservedBy,
    );
  }

  Future<Station> _fetchStation(String stationId) async {
    final response = await http.get(Uri.https(baseUrl, '/stations/$stationId.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load station $stationId');
    }

    return StationDto.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
      id: stationId,
    );
  }

  Future<Bicycle> _fetchBicycle(String bikeId) async {
    final response = await http.get(Uri.https(baseUrl, '/bicycles/$bikeId.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load bicycle $bikeId');
    }

    return BicycleDto.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
      id: bikeId,
    );
  }
}
