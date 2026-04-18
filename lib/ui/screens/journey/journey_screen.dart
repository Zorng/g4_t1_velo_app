import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/booking.dart';
import 'package:g4_t1_velo_app/ui/screens/station_detail/station_detail_screen.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Journey')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Station Slots Preview', style: AppTextStyles.title),
          const SizedBox(height: 8),
          Text(
            'Temporary entry point for US3 before the map flow is connected.',
            style: AppTextStyles.label.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 24),
          _StationLaunchTile(
            title: 'Central Market',
            subtitle: '6 slots with mixed bike availability',
            stationId: 'station_central_market',
          ),
          const SizedBox(height: 16),
          _StationLaunchTile(
            title: 'Riverside',
            subtitle: '5 slots with mixed bike availability',
            stationId: 'station_riverside',
          ),
        ],
      ),
    );
  }
}

class _StationLaunchTile extends StatelessWidget {
  const _StationLaunchTile({
    required this.title,
    required this.subtitle,
    required this.stationId,
  });

  final String title;
  final String subtitle;
  final String stationId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => StationDetailScreen(
                stationId: stationId,
                onSlotTap: (slot, stationName) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        Booking(slotId: slot, stationName: stationName),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
