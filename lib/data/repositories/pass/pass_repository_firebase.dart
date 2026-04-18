import 'dart:convert';

import 'package:g4_t1_velo_app/data/dto/pass_dto.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:http/http.dart' as http;

class PassRepositoryFirebase implements PassRepository {
  final String baseUrl = 'velocambodia-fbeee-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<List<Pass>> getPasses() async {
    final response = await http.get(Uri.https(baseUrl, '/passes.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load passes');
    }

    final body = json.decode(response.body);
    if (body == null) return [];

    final map = body as Map<String, dynamic>;
    return map.entries
        .map((e) => PassDto.fromJson(e.value as Map<String, dynamic>, id: e.key))
        .toList();
  }
}
