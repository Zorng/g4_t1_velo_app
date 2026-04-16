import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
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
import 'package:provider/provider.dart';

class BookingContent extends StatelessWidget {
  final BikeSlot slot;

  const BookingContent({super.key, required this.slot});

  Future<void> _navigateToSubscriptions(
    BuildContext context,
    BookingViewModel viewModel,
  ) async {
    final pass = await Navigator.of(context).push<Pass>(
      MaterialPageRoute(builder: (_) => const SubscriptionsScreen()),
    );
    if (pass != null) {
      viewModel.onPassPurchased(pass);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookingViewModel>();
    final bikeNo = slot.bike?.bikeNo ?? 'Unknown';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BookingHeader(),
          const SizedBox(height: 24),

          BookingInfoCard(slot: slot),
          const SizedBox(height: 28),

          SectionTitle(
            title: viewModel.hasPass
                ? 'Your Subscription Plan'
                : 'Choose how to ride',
          ),
          const SizedBox(height: 12),

          if (viewModel.hasPass) ...[
            PassAppliedCard(pass: viewModel.pass!),
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
              onTap: () => _navigateToSubscriptions(context, viewModel),
            ),
          ],

          const Spacer(),

          PrimaryButton(
            label: 'Release Bike',
            onPressed: () {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.of(context).pop();
              messenger.showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  content: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'Bike No. $bikeNo Successfully Released',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          if (viewModel.hasPass)
            BookingFooterNote(
              text: 'Covered by your ${viewModel.pass?.name ?? ''}',
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
