
import 'package:g4_t1_velo_app/main_common.dart';
import 'package:g4_t1_velo_app/data/repositories/station/mock_station_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:provider/provider.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    // 1 - Inject repositories
    Provider<StationRepository>(create: (_) => MockStationRepository()),

    // 2 - Inject the player state

    // 3 - Inject the  app setting state
  ];
}

List<InheritedProvider> get remoteProviders {
  return [
    // 1 - Inject repositories

    // 2 - Inject the player state

    // 3 - Inject the  app setting state
  ];
}

void main() {
  mainCommon(devProviders);
  // mainCommon(remoteProviders);
}
