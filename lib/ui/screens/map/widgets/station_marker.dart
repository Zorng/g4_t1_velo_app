import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/station.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class StationMarker extends StatelessWidget {
  const StationMarker({
    required this.station,
    required this.isSelected,
    this.onTap,
    super.key,
  });

  final Station station;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final int availableCount = station.getAvailableSlots().length;
    final Color pinColor = availableCount == 0
        ? Colors.grey
        : isSelected
        ? AppColors.neutralDark
        : appTheme.primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.location_on,
            color: pinColor,
            size: isSelected ? 80 : 72,
          ),
          Positioned(
            top: isSelected ? 18 : 20,
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: AppColors.neutralDark, width: 2)
                    : null,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Color(0x26000000),
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '$availableCount',
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
