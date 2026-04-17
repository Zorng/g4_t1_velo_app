import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/ui/screens/map/viewmodel/map_screen_vm.dart';
import 'package:g4_t1_velo_app/ui/screens/map/widgets/station_marker.dart';
import 'package:g4_t1_velo_app/ui/states/selected_station.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapScreenContent extends StatelessWidget {
  const MapScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MapScreenVm>();
    final selectedStation = context.watch<SelectedStation>();

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: MapScreenVm.initialCenter,
              initialZoom: MapScreenVm.initialZoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
              onTap: (_, _) => context.read<SelectedStation>().clear(),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'g4_t1_velo_app',
              ),
              MarkerLayer(
                markers: vm.stations.map((station) {
                  return Marker(
                    point: LatLng(
                      station.location.latitude,
                      station.location.longitude,
                    ),
                    width: 84,
                    height: 92,
                    child: StationMarker(
                      station: station,
                      isSelected: selectedStation.isSelected(station),
                      onTap: () => context.read<SelectedStation>().select(station),
                    ),
                  );
                }).toList(growable: false),
              ),
            ],
          ),
          const _MapHeader(),
          if (vm.isLoading) const _LoadingOverlay(),
          if (vm.error != null) _ErrorBanner(error: vm.error!),
          if (selectedStation.value != null)
            _SelectedStationCard(station: selectedStation.value!),
        ],
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
            boxShadow: const [
              BoxShadow(
                blurRadius: 16,
                color: Color(0x22000000),
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Station Map',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedStationCard extends StatelessWidget {
  const _SelectedStationCard({required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) {
    final availableCount = station.getAvailableSlots().length;

    return Positioned(
      left: 16,
      right: 16,
      bottom: 24,
      child: SafeArea(
        top: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 18,
                color: Color(0x1F000000),
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.pedal_bike, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        station.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text('${station.totalSlot} slots total'),
                      Text('$availableCount bicycles available'),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => context.read<SelectedStation>().clear(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0x22000000),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      top: 88,
      child: SafeArea(
        bottom: false,
        child: Material(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Failed to load stations: $error',
              style: TextStyle(color: Colors.red.shade900),
            ),
          ),
        ),
      ),
    );
  }
}
