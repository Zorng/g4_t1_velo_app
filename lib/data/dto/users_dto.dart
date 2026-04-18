class UsersDto {
  static const String activePassIdKey = 'activePassId';
  static const String currentBookingIdKey = 'currentBookingId';

  final String id;
  final String? activePassId;
  final String? currentBookingId;

  const UsersDto({
    required this.id,
    this.activePassId,
    this.currentBookingId,
  });

  static UsersDto fromJson(Map<String, dynamic> json, {required String id}) {
    return UsersDto(
      id: id,
      activePassId: json[activePassIdKey] as String?,
      currentBookingId: json[currentBookingIdKey] as String?,
    );
  }

  static Map<String, dynamic> toJson(UsersDto dto) {
    return {
      activePassIdKey: dto.activePassId,
      currentBookingIdKey: dto.currentBookingId,
    };
  }
}
