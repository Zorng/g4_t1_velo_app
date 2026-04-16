import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class PassAppliedCard extends StatelessWidget {
  final Pass pass;

  const PassAppliedCard({super.key, required this.pass});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.08),
        border: Border.all(color: Colors.green, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(
          '${pass.name} Applied',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.green,
          ),
        ),
        subtitle: Text(
          pass.description,
          style: TextStyle(fontSize: 11, color: AppColors.neutralLight),
        ),
      ),
    );
  }
}
