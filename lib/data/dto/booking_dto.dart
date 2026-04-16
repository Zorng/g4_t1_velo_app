class BookingDto {
  static const String userIdKey = 'userId';
  static const String slotIdKey = 'slotId';
  static const String passIdKey = 'passId';
  static const String startKey = 'start';
  static const String endKey = 'end';
  static const String statusKey = 'status';

  final String id;
  final String userId;
  final String slotId;
  final String? passId;
  final DateTime start;
  final DateTime? end;
  final String status;

  const BookingDto({
    required this.id,
    required this.userId,
    required this.slotId,
    this.passId,
    required this.start,
    this.end,
    required this.status,
  });

  static BookingDto fromJson(Map<String, dynamic> json, {required String id}) {
    assert(json[userIdKey] is String);
    assert(json[slotIdKey] is String);
    assert(json[statusKey] is String);

    return BookingDto(
      id: id,
      userId: json[userIdKey] as String,
      slotId: json[slotIdKey] as String,
      passId: json[passIdKey] as String?,
      start: DateTime.parse(json[startKey] as String),
      end: json[endKey] != null ? DateTime.parse(json[endKey] as String) : null,
      status: json[statusKey] as String,
    );
  }

  static Map<String, dynamic> toJson(BookingDto dto) {
    return {
      userIdKey: dto.userId,
      slotIdKey: dto.slotId,
      passIdKey: dto.passId,
      startKey: dto.start.toIso8601String(),
      endKey: dto.end?.toIso8601String(),
      statusKey: dto.status,
    };
  }
}
