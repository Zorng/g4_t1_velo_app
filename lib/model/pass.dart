class Pass {
  const Pass({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
}
