import 'package:g4_t1_velo_app/data/repositories/bicycle/bicycle_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/bicycle/bicycle_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/bicycle/bicycle_repository_mock.dart';
import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository_mock.dart';
import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository_mock.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository_mock.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository_mock.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/users/users_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/users/users_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/users/users_repository_mock.dart';
import 'package:g4_t1_velo_app/data/services/bike_slot_service.dart';
import 'package:g4_t1_velo_app/main_common.dart';
import 'package:provider/provider.dart';

const _firebaseBaseUrl =
    'velocambodia-fbeee-default-rtdb.asia-southeast1.firebasedatabase.app';

List<InheritedProvider> get devProviders {
  return [
    Provider<PassRepository>(create: (_) => PassRepositoryMock()),
    Provider<UsersRepository>(create: (_) => UsersRepositoryMock()),
    Provider<BookingRepository>(create: (_) => BookingRepositoryMock()),
    Provider<BicycleRepository>(create: (_) => BicycleRepositoryMock()),
    Provider<BikeSlotRepository>(create: (_) => BikeSlotRepositoryMock()),
    Provider<StationRepository>(create: (_) => MockStationRepository()),
  ];
}

List<InheritedProvider> get remoteProviders {
  return [
    Provider<PassRepository>(create: (_) => PassRepositoryFirebase()),
    Provider<UsersRepository>(create: (_) => UsersRepositoryFirebase()),
    Provider<BookingRepository>(create: (_) => BookingRepositoryFirebase()),
    Provider<BicycleRepository>(create: (_) => BicycleRepositoryFirebase()),
    Provider<BikeSlotService>(
      create: (ctx) => BikeSlotService(
        baseUrl: _firebaseBaseUrl,
        bicycleRepository: ctx.read<BicycleRepository>(),
      ),
    ),
    Provider<BikeSlotRepository>(
      create: (ctx) => BikeSlotRepositoryFirebase(
        bikeSlotService: ctx.read<BikeSlotService>(),
      ),
    ),
    Provider<StationRepository>(
      create: (ctx) => StationRepositoryFirebase(
        bikeSlotService: ctx.read<BikeSlotService>(),
      ),
    ),
  ];
}

void main() {
  // mainCommon(devProviders);
  mainCommon(remoteProviders);
}
