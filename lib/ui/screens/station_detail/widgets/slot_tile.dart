import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class SlotTile extends StatelessWidget {
  const SlotTile({
    super.key,
    required this.slot,
    this.onTap,
  });

  final BikeSlot slot;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // A slot is considered available when it currently contains a bike.
    final isAvailable = slot.status == SlotStatus.available;
    final statusColor = isAvailable ? Colors.green : AppColors.neutralLight;
    final statusText = isAvailable ? 'Available bike' : 'Empty slot';
    final bikeLabel = isAvailable
        ? 'Bike ${slot.bike!.bikeNo}'
        : 'No bike assigned';

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: isAvailable ? onTap : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: CircleAvatar(
          backgroundColor: statusColor.withValues(alpha: 0.14),
          child: Icon(
            isAvailable ? Icons.pedal_bike_rounded : Icons.remove_rounded,
            color: statusColor,
          ),
        ),
        title: Text('Slot ${slot.id}'),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(bikeLabel),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            statusText,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
