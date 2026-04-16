import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/ui/screens/station_detail/viewmodel/station_detail_view_model.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';
import 'package:g4_t1_velo_app/utils/async_value.dart';
import 'package:provider/provider.dart';

import 'slot_tile.dart';

class StationDetailContent extends StatelessWidget {
  const StationDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StationDetailViewModel>();
    final stationState = viewModel.stationState;

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
  });

  final Station station;
  final int availableBikeCount;
  final int emptySlotCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      // The first two items are static sections before the slot list.
      itemCount: station.slots.length + 2,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        if (index == 0) {
          return _StationHeader(station: station);
        }

        if (index == 1) {
          return _SlotSummary(
            totalSlotCount: station.slots.length,
            availableBikeCount: availableBikeCount,
            emptySlotCount: emptySlotCount,
          );
        }

        return SlotTile(slot: station.slots[index - 2]);
      },
    );
  }
}

class _StationHeader extends StatelessWidget {
  const _StationHeader({required this.station});

  final Station station;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(station.name, style: AppTextStyles.title.copyWith(fontSize: 28)),
          const SizedBox(height: 12),
          Text(
            station.location.address,
            style: AppTextStyles.label.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _SlotSummary extends StatelessWidget {
  const _SlotSummary({
    required this.totalSlotCount,
    required this.availableBikeCount,
    required this.emptySlotCount,
  });

  final int totalSlotCount;
  final int availableBikeCount;
  final int emptySlotCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'Total slots',
            value: '$totalSlotCount',
            valueColor: AppColors.neutralDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'Available bikes',
            value: '$availableBikeCount',
            valueColor: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'Empty slots',
            value: '$emptySlotCount',
            valueColor: AppColors.neutralLight,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.label.copyWith(fontSize: 14)),
          const SizedBox(height: 10),
          Text(
            value,
            style: AppTextStyles.title.copyWith(
              fontSize: 24,
              color: valueColor,
            ),
          ),
        ],
      ),
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
