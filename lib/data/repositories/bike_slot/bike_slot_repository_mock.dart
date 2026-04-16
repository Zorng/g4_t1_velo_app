import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:g4_t1_velo_app/model/bicycle.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/location.dart';
import 'package:g4_t1_velo_app/model/station.dart';

class BikeSlotRepositoryMock implements BikeSlotRepository {
  static final _slots = <BikeSlot>[
    BikeSlot(
      id: 'D-04',
      station: Station(
        id: 's1',
        name: 'Veal Vong Park',
        location: Location(
          id: 'l1',
          longitude: 104.9282,
          latitude: 11.5564,
          address: 'Veal Vong Park, Phnom Penh',
        ),
        totalSlot: 10,
        slots: [],
      ),
      bike: Bicycle(id: 'b1', bikeNo: 'BK-2047'),
    ),
  ];

  @override
  Future<BikeSlot> getSlot(String slotId) async {
    return _slots.firstWhere(
      (slot) => slot.id == slotId,
      orElse: () => throw Exception('Slot $slotId not found'),
    );
  }
}
