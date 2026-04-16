import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.neutralDark,
      ),
    );
  }
}
