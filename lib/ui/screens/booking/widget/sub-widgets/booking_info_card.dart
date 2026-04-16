import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/sub-widgets/booking_info_row.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class BookingInfoCard extends StatelessWidget {
  final BikeSlot slot;

  const BookingInfoCard({super.key, required this.slot});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          BookingInfoRow(label: 'Station Detail', value: slot.station.name),
          Divider(height: 1, color: AppColors.greyLight),
          BookingInfoRow(label: 'Dock Number', value: slot.id),
          Divider(height: 1, color: AppColors.greyLight),
          BookingInfoRow(label: 'Bike Number', value: slot.bike?.bikeNo ?? '-'),
        ],
      ),
    );
  }
}
