import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:g4_t1_velo_app/ui/screens/subscriptions/viewmodel/subscription_viewmodel.dart';
import 'package:g4_t1_velo_app/ui/screens/subscriptions/widget/pass_list.dart';
import 'package:g4_t1_velo_app/utils/async_value.dart';
import 'package:provider/provider.dart';

class SubscriptionContent extends StatelessWidget {
  const SubscriptionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SubscriptionViewModel>();
    final AsyncValue<List<Pass>> passValue = vm.passValue;
    Widget content;

    switch (passValue.state) {
      case AsyncValueState.loading:
        content = const Center(child: CircularProgressIndicator());
        break;
      case AsyncValueState.error:
        content = Center(
          child: Text(
            'Failed to load passes: ${passValue.error}',
            style: const TextStyle(color: Colors.red),
          ),
        );
      case AsyncValueState.success:
        content = PassList(
          passes: passValue.data!,
          selectedIndex: vm.selectedIndex,
          onSelect: vm.selectPass,
          onPurchase: () => Navigator.of(context).pop(vm.selectedPass),
        );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: content,
    );
  }
}
