import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class SlotTile extends StatelessWidget {
  const SlotTile({
    super.key,
    required this.slot,
    this.currentUserId,
    this.onTap,
  });

  final BikeSlot slot;
  final String? currentUserId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final status = slot.status;

    final isYourBooking =
        status == SlotStatus.reserved &&
        currentUserId != null &&
        slot.isBookedByUser(currentUserId!);

    final Color statusColor = switch (status) {
      SlotStatus.available => Colors.green,
      SlotStatus.reserved => isYourBooking ? Colors.blue : Colors.orange,
      SlotStatus.empty => AppColors.neutralLight,
    };

    final String statusText = switch (status) {
      SlotStatus.available => 'Available',
      SlotStatus.reserved => isYourBooking ? 'Your Booking' : 'Reserved',
      SlotStatus.empty => 'Empty slot',
    };

    final IconData statusIcon = switch (status) {
      SlotStatus.available => Icons.pedal_bike_rounded,
      SlotStatus.reserved =>
        isYourBooking ? Icons.check_circle_rounded : Icons.lock_rounded,
      SlotStatus.empty => Icons.remove_rounded,
    };

    final String bikeLabel = switch (status) {
      SlotStatus.available => 'Bike ${slot.bike!.bikeNo}',
      SlotStatus.reserved => 'Bike ${slot.bike!.bikeNo}',
      SlotStatus.empty => 'No bike assigned',
    };

    final bool tappable = status == SlotStatus.available;

    return Opacity(
      opacity: tappable || isYourBooking ? 1.0 : 0.5,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: tappable ? 2 : 0,
        shape: isYourBooking
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.withValues(alpha: 0.4)),
              )
            : null,
        color: isYourBooking ? Colors.blue.withValues(alpha: 0.05) : null,
        child: ListTile(
          onTap: tappable ? onTap : null,
          mouseCursor: tappable
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          leading: CircleAvatar(
            backgroundColor: statusColor.withValues(alpha: 0.14),
            child: Icon(statusIcon, color: statusColor),
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
      ),
    );
  }
}
