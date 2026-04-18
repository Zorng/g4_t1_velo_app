import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/booking_info_tile.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class BookingInfoCard extends StatelessWidget {
  final BikeSlot slot;
  final String stationName;

  const BookingInfoCard({super.key, required this.slot, required this.stationName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          BookingInfoTile(label: 'Station Detail', value: stationName),
          Divider(height: 1, color: AppColors.greyLight),
          BookingInfoTile(label: 'Dock Number', value: slot.id),
          Divider(height: 1, color: AppColors.greyLight),
          BookingInfoTile(label: 'Bike Number', value: slot.bike?.bikeNo ?? '-'),
        ],
      ),
    );
  }
}
