import 'package:g4_t1_velo_app/data/dto/location_dto.dart';
import 'package:g4_t1_velo_app/model/station.dart';

class StationDto {
  static const String nameKey = 'name';
  static const String totalSlotKey = 'totalSlot';
  static const String locationKey = 'location';

  static Station fromJson(Map<String, dynamic> json, {required String id}) {
    assert(json[nameKey] is String);
    assert(json[totalSlotKey] is int);
    assert(json[locationKey] is Map<String, dynamic>);

    return Station(
      id: id,
      name: json[nameKey] as String,
      totalSlot: json[totalSlotKey] as int,
      slots: [],
      location: LocationDto.fromJson(
        json[locationKey] as Map<String, dynamic>,
        id: id,
      ),
    );
  }
}
