import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/ui/screens/station_detail/viewmodel/station_detail_view_model.dart';
import 'package:g4_t1_velo_app/utils/async_value.dart';
import 'package:provider/provider.dart';

import 'slot_tile.dart';
import 'slot_summary.dart';
import 'station_header.dart';

class StationDetailContent extends StatelessWidget {
  const StationDetailContent({super.key, this.onSlotTap});

  // Hardcoded for demo
  static const _currentUserId = 'user_mock_1';

  final Future<void> Function(String slotId, String stationName)? onSlotTap;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StationDetailViewModel>();
    final stationState = viewModel.stationState;
    final wrappedOnSlotTap = onSlotTap == null
        ? null
        : (BikeSlot slot, String stationName) async {
            await onSlotTap!(slot.id, stationName);
            if (context.mounted) await viewModel.load();
          };

    return Scaffold(
      appBar: AppBar(title: const Text('Station Details')),
      body: Builder(
        builder: (context) {
          // Render one UI branch based on the async state from the view model.
          if (stationState.state == AsyncValueState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (stationState.state == AsyncValueState.error) {
            return _ErrorState(
              message: stationState.error.toString(),
              onRetry: viewModel.load,
            );
          }

          final station = stationState.data!;

          return _LoadedStationDetail(
            station: station,
            availableBikeCount: viewModel.availableBikeCount,
            emptySlotCount: viewModel.emptySlotCount,
            currentUserId: _currentUserId,
            onSlotTap: wrappedOnSlotTap == null
                ? null
                : (slot) => wrappedOnSlotTap(slot, station.name),
          );
        },
      ),
    );
  }
}

class _LoadedStationDetail extends StatelessWidget {
  const _LoadedStationDetail({
    required this.station,
    required this.availableBikeCount,
    required this.emptySlotCount,
    this.currentUserId,
    this.onSlotTap,
  });

  final Station station;
  final int availableBikeCount;
  final int emptySlotCount;
  final String? currentUserId;
  final Future<void> Function(BikeSlot)? onSlotTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        StationHeader(station: station),
        const SizedBox(height: 16),
        SlotSummary(
          totalSlotCount: station.slots.length,
          availableBikeCount: availableBikeCount,
          emptySlotCount: emptySlotCount,
        ),
        const SizedBox(height: 16),
        for (final slot in station.slots) ...[
          SlotTile(
            slot: slot,
            currentUserId: currentUserId,
            onTap: onSlotTap == null ? null : () => onSlotTap!(slot),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
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
