import 'dart:convert';

import 'package:g4_t1_velo_app/data/dto/station_dto.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:g4_t1_velo_app/data/services/bike_slot_service.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:http/http.dart' as http;

class StationRepositoryFirebase implements StationRepository {
  const StationRepositoryFirebase({required BikeSlotService bikeSlotService})
      : _service = bikeSlotService;

  static const _baseUrl =
      'velocambodia-fbeee-default-rtdb.asia-southeast1.firebasedatabase.app';

  final BikeSlotService _service;

  @override
  Future<List<Station>> getStations() async {
    final response = await http.get(Uri.https(_baseUrl, '/stations.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load stations');
    }

    final body = json.decode(response.body);
    if (body == null) return [];

    final data = body as Map<String, dynamic>;
    return Future.wait(
      data.entries.map((e) => _buildStation(e.key, e.value as Map<String, dynamic>)),
    );
  }

  @override
  Future<Station?> getStationById(String id) async {
    final response = await http.get(Uri.https(_baseUrl, '/stations/$id.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load station $id');
    }

    final body = json.decode(response.body);
    if (body == null) return null;

    return _buildStation(id, body as Map<String, dynamic>);
  }

  Future<Station> _buildStation(String id, Map<String, dynamic> data) async {
    final base = StationDto.fromJson(data, id: id);
    final slots = await _fetchSlotsForStation(id);
    return Station(
      id: base.id,
      name: base.name,
      location: base.location,
      totalSlot: base.totalSlot,
      slots: slots,
    );
  }

  Future<List<BikeSlot>> _fetchSlotsForStation(String stationId) async {
    final response = await http.get(
      Uri.https(_baseUrl, '/slots.json', {
        'orderBy': '"stationId"',
        'equalTo': '"$stationId"',
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to load slots for station $stationId');
    }

    final body = json.decode(response.body);
    if (body == null) return [];

    final data = body as Map<String, dynamic>;
    return Future.wait(
      data.entries.map((e) => _service.buildSlot(e.key, e.value as Map<String, dynamic>)),
    );
  }
}
