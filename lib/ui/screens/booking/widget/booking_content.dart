import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/viewmodel/booking_viewmodel.dart';
import 'package:g4_t1_velo_app/ui/screens/subscriptions/subscriptions_screen.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/booking_footer_note.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/booking_header.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/booking_info_card.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/labeled_divider.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/pass_applied_card.dart';
import 'package:g4_t1_velo_app/ui/widgets/primary_button.dart';
import 'package:g4_t1_velo_app/ui/widgets/selectable_card.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/section_title.dart';
import 'package:g4_t1_velo_app/utils/async_value.dart';
import 'package:provider/provider.dart';

class BookingContent extends StatelessWidget {
  const BookingContent({super.key});

  Future<void> _navigateToSubscriptions(
    BuildContext context,
    BookingViewModel vm,
  ) async {
    final pass = await Navigator.of(context).push<Pass>(
      MaterialPageRoute(builder: (_) => const SubscriptionsScreen()),
    );
    if (pass != null) {
      await vm.onPassPurchased(pass);
    }
  }

  Future<void> _onConfirmPressed(
    BuildContext context,
    BookingViewModel vm,
  ) async {
    await vm.confirmBooking();
    if (!context.mounted) return;

    if (vm.confirmValue?.state == AsyncValueState.success) {
      final bikeNo = vm.slot?.bike?.bikeNo ?? '';
      //pop back to the map screen
      Navigator.of(context).popUntil((route) => route.isFirst);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bike No. $bikeNo Successfully Booked'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (vm.confirmValue?.state == AsyncValueState.error) {
      final error = vm.confirmValue!.error;
      if (error is BookingError) {
        if (error == BookingError.alreadyBooked) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
          Navigator.of(context).pop();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message), backgroundColor: Colors.orange),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error?.toString() ?? 'Booking failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BookingViewModel>();

    final Widget body;
    if (vm.isInitializing) {
      body = const Center(child: CircularProgressIndicator());
    } else if (vm.hasInitError) {
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Failed to load booking details'),
            const SizedBox(height: 12),
            TextButton(onPressed: vm.retry, child: const Text('Retry')),
          ],
        ),
      );
    } else {
      body = _buildForm(context, vm);
    }

    return body;
  }

  Widget _buildForm(BuildContext context, BookingViewModel vm) {
    final isConfirming = vm.confirmValue?.state == AsyncValueState.loading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BookingHeader(),
          const SizedBox(height: 24),

          BookingInfoCard(slot: vm.slot!, stationName: vm.stationName),
          const SizedBox(height: 28),

          SectionTitle(
            title: vm.hasPass ? 'Your Subscription Plan' : 'Choose how to ride',
          ),
          const SizedBox(height: 12),

          if (vm.hasPass) ...[
            PassAppliedCard(pass: vm.activePass!),
          ] else ...[
            const SelectableCard(
              title: 'Single Trip',
              subtitle:
                  'Quick ride without subscription. Best for one-time booking.',
              isSelected: true,
            ),
            const SizedBox(height: 12),
            const LabelDivider(),
            const SizedBox(height: 12),
            SelectableCard(
              title: 'Buy A Pass',
              subtitle: 'Choose a Day, Monthly or Annual Pass',
              showArrow: true,
              onTap: () => _navigateToSubscriptions(context, vm),
            ),
          ],

          const Spacer(),

          PrimaryButton(
            label: 'Confirm Booking',
            onPressed: isConfirming
                ? null
                : () => _onConfirmPressed(context, vm),
          ),
          const SizedBox(height: 12),

          if (vm.hasPass)
            BookingFooterNote(
              text: 'Covered by your ${vm.activePass?.name ?? ''}',
              iconColor: Colors.green,
              textColor: Colors.green,
            )
          else
            const BookingFooterNote(
              text: '\$1.50 Charged On Release',
              iconColor: Colors.green,
              textColor: Colors.green,
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
