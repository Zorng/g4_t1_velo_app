import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:g4_t1_velo_app/ui/widgets/selectable_card.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';
import 'package:g4_t1_velo_app/ui/widgets/primary_button.dart';

class PassList extends StatelessWidget {
  final List<Pass> passes;
  final int selectedIndex;
  final void Function(int) onSelect;
  final VoidCallback onPurchase;

  const PassList({
    super.key,
    required this.passes,
    required this.selectedIndex,
    required this.onSelect,
    required this.onPurchase,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          for (int i = 0; i < passes.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SelectableCard(
                title: passes[i].name,
                subtitle: passes[i].description,
                isSelected: i == selectedIndex,
                trailing: Text(
                  '\$${passes[i].price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutralDark,
                  ),
                ),
                onTap: () => onSelect(i),
              ),
            ),
          const Spacer(),
          PrimaryButton(
            label: 'Purchase',
            onPressed: onPurchase,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
