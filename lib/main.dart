import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository_firebase.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository_mock.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository.dart';
import 'package:g4_t1_velo_app/main_common.dart';
import 'package:provider/provider.dart';

/// Configure provider dependencies for dev environment
List<InheritedProvider> get devProviders {
  return [
    // 1 - Inject repositories
    Provider<PassRepository>(create: (_) => PassRepositoryMock()),

    // 2 - Inject the player state

    // 3 - Inject the app setting state
  ];
}

List<InheritedProvider> get remoteProviders {
  return [
    // 1 - Inject repositories
    Provider<PassRepository>(create: (_) => PassRepositoryFirebase()),

    // 2 - Inject the player state

    // 3 - Inject the app setting state
  ];
}

void main() {
  mainCommon(devProviders);
  // mainCommon(remoteProviders);
}
