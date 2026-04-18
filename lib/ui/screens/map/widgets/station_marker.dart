import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class StationMarker extends StatelessWidget {
  const StationMarker({super.key, required this.station, this.onTap});

  final Station station;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final availableBikeCount = station.getAvailableSlots().length;
    final pinColor = availableBikeCount > 0
        ? appTheme.primaryColor
        : AppColors.neutralLighter;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Icon(Icons.location_on, color: pinColor, size: 72),
          Positioned(
            top: 72,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Color(0x26000000),
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                station.name,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.visible,
                style: AppTextStyles.label.copyWith(fontSize: 10),
              ),
            ),
          ),
          Positioned(
            top: 32,
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Color(0x26000000),
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '$availableBikeCount',
                style: TextStyle(
                  color: AppColors.neutralDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
