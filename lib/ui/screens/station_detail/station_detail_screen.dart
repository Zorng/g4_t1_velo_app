import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/data/repositories/station/station_repository.dart';
import 'package:g4_t1_velo_app/ui/screens/station_detail/viewmodel/station_detail_view_model.dart';
import 'package:g4_t1_velo_app/ui/screens/station_detail/widgets/station_detail_content.dart';
import 'package:provider/provider.dart';

class StationDetailScreen extends StatelessWidget {
  const StationDetailScreen({super.key, required this.stationId});

  final String stationId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StationDetailViewModel>(
      create: (context) => StationDetailViewModel(
        stationRepository: context.read<StationRepository>(),
        stationId: stationId,
      )..load(),
      child: const StationDetailContent(),
    );
  }
}
