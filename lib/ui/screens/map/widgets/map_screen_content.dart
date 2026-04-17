import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/ui/screens/map/viewmodel/map_screen_view_model.dart';
import 'package:g4_t1_velo_app/ui/screens/map/widgets/station_marker.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/booking.dart';
import 'package:g4_t1_velo_app/ui/screens/station_detail/station_detail_screen.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';
import 'package:g4_t1_velo_app/utils/async_value.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapScreenContent extends StatelessWidget {
  const MapScreenContent({super.key});

  static const _initialCenter = LatLng(11.5715, 104.9228);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MapScreenViewModel>();
    final stationState = viewModel.stationState;

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: _initialCenter,
              initialZoom: 14,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'g4_t1_velo_app',
              ),
              if (stationState.state == AsyncValueState.success)
                MarkerLayer(
                  markers: viewModel.stations
                      .map((station) {
                        return Marker(
                          point: LatLng(
                            station.location.latitude,
                            station.location.longitude,
                          ),
                          width: 72,
                          height: 84,
                          child: StationMarker(
                            station: station,
                            onTap: () => _openStationDetail(context, station),
                          ),
                        );
                      })
                      .toList(growable: false),
                ),
            ],
          ),
          const _MapHeader(),
          if (stationState.state == AsyncValueState.loading)
            const _CenteredOverlay(child: CircularProgressIndicator()),
          if (stationState.state == AsyncValueState.error)
            _CenteredOverlay(
              child: _MapErrorState(
                message: stationState.error.toString(),
                onRetry: viewModel.load,
              ),
            ),
        ],
      ),
    );
  }

  void _openStationDetail(BuildContext context, Station station) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StationDetailScreen(
          stationId: station.id,
          onSlotTap: (slot, stationName) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => Booking(slotId: slot, stationName: stationName),
            ),
          ),
        ),
      ),
    );
  }
}

class _MapHeader extends StatelessWidget {
  const _MapHeader();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Map', style: AppTextStyles.title.copyWith(fontSize: 24)),
                const SizedBox(height: 4),
                Text(
                  'Tap a station marker to open station details.',
                  style: AppTextStyles.label.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CenteredOverlay extends StatelessWidget {
  const _CenteredOverlay({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white.withValues(alpha: 0.6),
      child: Center(child: child),
    );
  }
}

class _MapErrorState extends StatelessWidget {
  const _MapErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
