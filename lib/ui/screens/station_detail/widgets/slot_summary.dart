import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class SlotSummary extends StatelessWidget {
  const SlotSummary({
    super.key,
    required this.totalSlotCount,
    required this.availableBikeCount,
    required this.emptySlotCount,
  });

  final int totalSlotCount;
  final int availableBikeCount;
  final int emptySlotCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: 'Total slots',
            value: '$totalSlotCount',
            valueColor: AppColors.neutralDark,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'Available bikes',
            value: '$availableBikeCount',
            valueColor: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            label: 'Empty slots',
            value: '$emptySlotCount',
            valueColor: AppColors.neutralLight,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.label.copyWith(fontSize: 14)),
          const SizedBox(height: 10),
          Text(
            value,
            style: AppTextStyles.title.copyWith(
              fontSize: 24,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
