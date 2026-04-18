import 'dart:convert';

import 'package:g4_t1_velo_app/data/dto/bike_slot_dto.dart';
import 'package:g4_t1_velo_app/data/repositories/bicycle/bicycle_repository.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:http/http.dart' as http;

class BikeSlotService {
  const BikeSlotService({
    required this.baseUrl,
    required this.bicycleRepository,
  });

  final String baseUrl;
  final BicycleRepository bicycleRepository;

  Future<BikeSlot> fetchSlot(String slotId) async {
    final response = await http.get(Uri.https(baseUrl, '/slots/$slotId.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load slot $slotId');
    }
    return buildSlot(slotId, json.decode(response.body) as Map<String, dynamic>);
  }

  Future<BikeSlot> buildSlot(String slotId, Map<String, dynamic> data) async {
    final dto = BikeSlotDto.fromJson(data);
    final bike = dto.bikeId != null ? await bicycleRepository.getBicycle(dto.bikeId!) : null;
    return BikeSlot(
      id: slotId,
      stationId: dto.stationId,
      bike: bike,
      reservedBy: dto.reservedBy,
    );
  }
}
