import 'package:g4_t1_velo_app/model/pass.dart';

class PassDto {
  static const String nameKey = 'name';
  static const String descriptionKey = 'description';
  static const String priceKey = 'price';
  static const String startDateKey = 'startDate';
  static const String endDateKey = 'endDate';

  static Pass fromJson(Map<String, dynamic> json, {required String id}) {
    assert(json[nameKey] is String);
    assert(json[descriptionKey] is String);
    assert(json[priceKey] is num);
    assert(json[startDateKey] is String);
    assert(json[endDateKey] is String);

    return Pass(
      id: id,
      name: json[nameKey] as String,
      description: json[descriptionKey] as String,
      price: (json[priceKey] as num).toDouble(),
      startDate: DateTime.parse(json[startDateKey] as String),
      endDate: DateTime.parse(json[endDateKey] as String),
    );
  }

  static Map<String, dynamic> toJson(Pass pass) {
    return {
      nameKey: pass.name,
      descriptionKey: pass.description,
      priceKey: pass.price,
      startDateKey: pass.startDate.toIso8601String(),
      endDateKey: pass.endDate.toIso8601String(),
    };
  }
}
