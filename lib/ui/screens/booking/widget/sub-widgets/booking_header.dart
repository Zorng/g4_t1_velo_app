import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class BookingHeader extends StatelessWidget {
  const BookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Booking',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.neutralDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Review Information before unlocking the bike',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.neutralLight,
          ),
        ),
      ],
    );
  }
}
