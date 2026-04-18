import 'dart:convert';
import 'package:g4_t1_velo_app/data/dto/pass_dto.dart';
import 'package:g4_t1_velo_app/data/dto/users_dto.dart';
import 'package:g4_t1_velo_app/data/repositories/users/users_repository.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:http/http.dart' as http;

class UsersRepositoryFirebase implements UsersRepository {
  final String baseUrl = 'velocambodia-fbeee-default-rtdb.asia-southeast1.firebasedatabase.app';

  Future<UsersDto?> _fetchUser(String userId) async {
    final response = await http.get(Uri.https(baseUrl, '/users/$userId.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load user $userId');
    }
    final body = json.decode(response.body);
    if (body == null) return null;
    return UsersDto.fromJson(body as Map<String, dynamic>, id: userId);
  }

  @override
  Future<Pass?> getActivePass(String userId) async {
    final dto = await _fetchUser(userId);
    if (dto?.activePassId == null) return null;

    final passResponse = await http.get(
      Uri.https(baseUrl, '/passes/${dto!.activePassId}.json'),
    );
    if (passResponse.statusCode != 200) return null;

    final passJson = json.decode(passResponse.body);
    if (passJson == null) return null;

    return PassDto.fromJson(passJson as Map<String, dynamic>, id: dto.activePassId!);
  }

  @override
  Future<void> updateActivePass(String userId, Pass pass) async {
    final response = await http.patch(
      Uri.https(baseUrl, '/users/$userId.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({UsersDto.activePassIdKey: pass.id}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update active pass for user $userId');
    }
  }

  @override
  Future<String?> getCurrentBookingId(String userId) async {
    final dto = await _fetchUser(userId);
    return dto?.currentBookingId;
  }

  @override
  Future<void> updateCurrentBookingId(String userId, String bookingId) async {
    final response = await http.patch(
      Uri.https(baseUrl, '/users/$userId.json'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({UsersDto.currentBookingIdKey: bookingId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update current booking for user $userId');
    }
  }
}
