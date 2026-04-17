import 'dart:convert';

import 'package:g4_t1_velo_app/data/dto/bicycle_dto.dart';
import 'package:g4_t1_velo_app/data/repositories/bicycle/bicycle_repository.dart';
import 'package:g4_t1_velo_app/model/bicycle.dart';
import 'package:http/http.dart' as http;

class BicycleRepositoryFirebase implements BicycleRepository {
  static const _baseUrl =
      'velocambodia-fbeee-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<Bicycle> getBicycle(String id) async {
    final response = await http.get(Uri.https(_baseUrl, '/bicycles/$id.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load bicycle $id');
    }
    return BicycleDto.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
      id: id,
    );
  }
}
