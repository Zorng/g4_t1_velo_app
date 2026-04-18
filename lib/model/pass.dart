class Pass {
  Pass({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
  });

  Pass.singleTrip()
      : id = 'single_trip_${DateTime.now().millisecondsSinceEpoch}',
        name = 'Single Trip',
        description = 'Pay per ride',
        price = 1.50,
        startDate = DateTime.now(),
        endDate = DateTime.now().add(const Duration(hours: 1));

  final String id;
  final String name;
  final String description;
  final double price;
  final DateTime startDate;
  final DateTime endDate;

  bool get isActive =>
      DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate);
}
