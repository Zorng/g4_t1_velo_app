import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository_mock.dart';
import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository_mock.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository_mock.dart';
import 'package:g4_t1_velo_app/data/repositories/users/users_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/users/users_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/users/users_repository_mock.dart';

import 'package:g4_t1_velo_app/main_common.dart';
import 'package:g4_t1_velo_app/data/repositories/station/mock_station_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:provider/provider.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    // 1 - Inject repositories
    Provider<PassRepository>(create: (_) => PassRepositoryMock()),
    Provider<UsersRepository>(create: (_) => UsersRepositoryMock()),
    Provider<BookingRepository>(create: (_) => BookingRepositoryMock()),
    Provider<BikeSlotRepository>(create: (_) => BikeSlotRepositoryMock()),
    Provider<StationRepository>(create: (_) => MockStationRepository()),
    // 2 - Inject the player state

    // 3 - Inject the app setting state

    // 2 - Inject the player state

    // 3 - Inject the  app setting state
  ];
}

List<InheritedProvider> get remoteProviders {
  return [
    // 1 - Inject repositories
    Provider<PassRepository>(create: (_) => PassRepositoryFirebase()),
    Provider<UsersRepository>(create: (_) => UsersRepositoryFirebase()),
    Provider<BookingRepository>(create: (_) => BookingRepositoryFirebase()),
    Provider<BikeSlotRepository>(create: (_) => BikeSlotRepositoryFirebase()),

    // 2 - Inject the player state

    // 3 - Inject the app setting state
  ];
}

void main() {
  mainCommon(devProviders);
  // mainCommon(remoteProviders);
}
