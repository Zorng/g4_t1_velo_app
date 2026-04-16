import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';

class SelectableCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final bool showArrow;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SelectableCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
    this.showArrow = false,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? appTheme.primaryColor.withValues(alpha: 0.15)
              : appTheme.scaffoldBackgroundColor,
          border: Border.all(
            color: isSelected ? appTheme.primaryColor : AppColors.greyLight,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.neutralDark,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 11, color: AppColors.neutralLight),
          ),
          trailing: showArrow
              ? Icon(Icons.chevron_right, color: AppColors.neutralDark)
              : trailing,
        ),
      ),
    );
  }
}
