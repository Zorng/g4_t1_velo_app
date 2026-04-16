class Pass {
  const Pass({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final DateTime startDate;
  final DateTime endDate;

  bool get isActive =>
      DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate);
}
