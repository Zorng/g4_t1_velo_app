import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:g4_t1_velo_app/ui/screens/map/viewmodel/map_screen_view_model.dart';
import 'package:g4_t1_velo_app/ui/screens/map/widgets/map_screen_content.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapScreenViewModel>(
      create: (context) => MapScreenViewModel(
        stationRepository: context.read<StationRepository>(),
      )..load(),
      child: const MapScreenContent(),
    );
  }
}
