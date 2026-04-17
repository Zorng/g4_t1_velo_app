import 'package:g4_t1_velo_app/model/bicycle.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/booking.dart';
import 'package:g4_t1_velo_app/model/location.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/model/users.dart';

class MockData {
  MockData._();

  static final MockData instance = MockData._();

  late final List<Location> locations = [
    const Location(
      id: 'location_central_market',
      longitude: 104.9216,
      latitude: 11.5696,
      address: 'Central Market, Phnom Penh',
    ),
    const Location(
      id: 'location_wat_phnom',
      longitude: 104.9282,
      latitude: 11.5764,
      address: 'Wat Phnom, Phnom Penh',
    ),
    const Location(
      id: 'location_riverside',
      longitude: 104.9299,
      latitude: 11.5681,
      address: 'Sisowath Quay, Phnom Penh',
    ),
  ];

  late final List<Bicycle> bicycles = [
    const Bicycle(id: 'bicycle_001', bikeNo: 'BK-001'),
    const Bicycle(id: 'bicycle_002', bikeNo: 'BK-002'),
    const Bicycle(id: 'bicycle_003', bikeNo: 'BK-003'),
    const Bicycle(id: 'bicycle_004', bikeNo: 'BK-004'),
    const Bicycle(id: 'bicycle_005', bikeNo: 'BK-005'),
    const Bicycle(id: 'bicycle_006', bikeNo: 'BK-006'),
  ];

  late final List<Pass> passes = [
    Pass(
      id: 'pass_active_monthly',
      startDate: DateTime(2026, 4, 1),
      endDate: DateTime(2026, 4, 30, 23, 59, 59),
      isActive: true,
    ),
    Pass(
      id: 'pass_active_weekly',
      startDate: DateTime(2026, 4, 13),
      endDate: DateTime(2026, 4, 20, 23, 59, 59),
      isActive: true,
    ),
    Pass(
      id: 'pass_expired',
      startDate: DateTime(2026, 3, 1),
      endDate: DateTime(2026, 3, 31, 23, 59, 59),
      isActive: false,
    ),
  ];

  late final List<Station> stations = _buildStations();
  late final List<Users> users = _buildUsers();
  late final List<Booking> bookings = _buildBookings();

  List<Station> _buildStations() {
    final centralMarket = Station(
      id: 'station_central_market',
      name: 'Central Market',
      location: locations[0],
      totalSlot: 4,
      slots: [],
    );

    final watPhnom = Station(
      id: 'station_wat_phnom',
      name: 'Wat Phnom',
      location: locations[1],
      totalSlot: 4,
      slots: [],
    );

    final riverSide = Station(
      id: 'station_riverside',
      name: 'Riverside',
      location: locations[2],
      totalSlot: 4,
      slots: [],
    );

    centralMarket.slots.addAll([
      BikeSlot(id: 'slot_cm_01', station: centralMarket, bike: bicycles[0]),
      BikeSlot(id: 'slot_cm_02', station: centralMarket, bike: bicycles[1]),
      BikeSlot(id: 'slot_cm_03', station: centralMarket),
      BikeSlot(id: 'slot_cm_04', station: centralMarket, bike: bicycles[2]),
    ]);

    watPhnom.slots.addAll([
      BikeSlot(id: 'slot_wp_01', station: watPhnom),
      BikeSlot(id: 'slot_wp_02', station: watPhnom,),
      BikeSlot(id: 'slot_wp_03', station: watPhnom),
      BikeSlot(id: 'slot_wp_04', station: watPhnom,),
    ]);

    riverSide.slots.addAll([
      BikeSlot(id: 'slot_rs_01', station: riverSide, bike: bicycles[5]),
      BikeSlot(id: 'slot_rs_02', station: riverSide),
      BikeSlot(id: 'slot_rs_03', station: riverSide),
      BikeSlot(id: 'slot_rs_04', station: riverSide),
    ]);

    return [centralMarket, watPhnom, riverSide];
  }

  List<Users> _buildUsers() {
    return [
      Users(id: 'user_sokha', activePass: passes[0]),
      Users(id: 'user_dara', activePass: passes[1]),
      Users(id: 'user_malis', activePass: passes[2]),
      const Users(id: 'user_guest'),
    ];
  }

  List<Booking> _buildBookings() {
    return [
      Booking(
        id: 'booking_001',
        user: users[0],
        slot: stations[0].slots[0],
        pass: passes[0],
        start: DateTime(2026, 4, 15, 8, 0),
        end: DateTime(2026, 4, 15, 8, 45),
        status: BookingStatus.confirmed,
      ),
      Booking(
        id: 'booking_002',
        user: users[1],
        slot: stations[1].slots[1],
        pass: passes[1],
        start: DateTime(2026, 4, 15, 9, 30),
        status: BookingStatus.pending,
      ),
      Booking(
        id: 'booking_003',
        user: users[2],
        slot: stations[2].slots[0],
        pass: passes[2],
        start: DateTime(2026, 4, 10, 18, 0),
        end: DateTime(2026, 4, 10, 18, 20),
        status: BookingStatus.cancelled,
      ),
    ];
  }
}
