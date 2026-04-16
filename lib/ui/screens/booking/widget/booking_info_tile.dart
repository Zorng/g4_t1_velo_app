import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class BookingInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const BookingInfoTile({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: AppColors.neutralLight,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.neutralDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
