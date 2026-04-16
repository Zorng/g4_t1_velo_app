import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/viewmodel/booking_viewmodel.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/booking_content.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class Booking extends StatelessWidget {
  final BikeSlot slot;

  const Booking({super.key, required this.slot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Booking Details',
          style: AppTextStyles.title.copyWith(
            color: AppColors.text,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: ChangeNotifierProvider(
        create: (_) => BookingViewModel(),
        child: BookingContent(slot: slot),
      ),
    );
  }
}
