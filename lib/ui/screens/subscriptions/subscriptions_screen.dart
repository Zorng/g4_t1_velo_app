import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository.dart';
import 'package:g4_t1_velo_app/ui/screens/subscriptions/viewmodel/subscription_viewmodel.dart';
import 'package:g4_t1_velo_app/ui/screens/subscriptions/widget/subscription_content.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appTheme.scaffoldBackgroundColor,
        leading: BackButton(color: AppColors.text),
        title: Text(
          'Select a Pass',
          style: AppTextStyles.title.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: ChangeNotifierProvider(
        create: (context) => SubscriptionViewModel(
          context.read<PassRepository>(),
        ),
        child: const SubscriptionContent(),
      ),
    );
  }
}
