import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class StationHeader extends StatelessWidget {
  const StationHeader({super.key, required this.station});

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
