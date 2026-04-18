import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository.dart';
import 'package:g4_t1_velo_app/model/pass.dart';

class PassRepositoryMock implements PassRepository {
  @override
  Future<List<Pass>> getPasses() async {
    return [
      Pass(
        id: 'p1',
        name: 'Day Pass',
        description:
            'Unlimited rides for 24 hours. Perfect for short visits or daily use.',
        price: 2.50,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 1)),
      ),
      Pass(
        id: 'p2',
        name: 'Monthly Pass',
        description:
            'Ride anytime for a full month. Ideal for regular commuters.',
        price: 25.00,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
      ),
      Pass(
        id: 'p3',
        name: 'Annual Pass',
        description:
            'Best value for frequent riders. Unlimited access all year long.',
        price: 199.00,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365)),
      ),
    ];
  }
}
