class BikeSlotDto {
  static const String stationIdKey = 'stationId';
  static const String bikeIdKey = 'bikeId';
  static const String reservedByKey = 'reservedBy';

  const BikeSlotDto({
    required this.stationId,
    this.bikeId,
    this.reservedBy,
  });

  final String stationId;
  final String? bikeId;
  final String? reservedBy;

  static BikeSlotDto fromJson(Map<String, dynamic> json) {
    assert(json[stationIdKey] is String);

    return BikeSlotDto(
      stationId: json[stationIdKey] as String,
      bikeId: json[bikeIdKey] as String?,
      reservedBy: json[reservedByKey] as String?,
    );
  }
}
