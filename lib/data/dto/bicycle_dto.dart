import 'package:g4_t1_velo_app/model/bicycle.dart';

class BicycleDto {
  static const String bikeNoKey = 'bikeNo';

  static Bicycle fromJson(Map<String, dynamic> json, {required String id}) {
    assert(json[bikeNoKey] is String);

    return Bicycle(
      id: id,
      bikeNo: json[bikeNoKey] as String,
    );
  }
}
