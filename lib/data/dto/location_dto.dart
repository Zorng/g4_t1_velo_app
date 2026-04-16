import 'package:g4_t1_velo_app/model/location.dart';

class LocationDto {
  static const String longitudeKey = 'longitude';
  static const String latitudeKey = 'latitude';
  static const String addressKey = 'address';

  static Location fromJson(Map<String, dynamic> json, {required String id}) {
    assert(json[longitudeKey] is num);
    assert(json[latitudeKey] is num);
    assert(json[addressKey] is String);

    return Location(
      id: id,
      longitude: (json[longitudeKey] as num).toDouble(),
      latitude: (json[latitudeKey] as num).toDouble(),
      address: json[addressKey] as String,
    );
  }
}
