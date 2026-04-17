import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/users/users_repository.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/viewmodel/booking_viewmodel.dart';
import 'package:g4_t1_velo_app/ui/screens/booking/widget/booking_content.dart';
import 'package:g4_t1_velo_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class Booking extends StatelessWidget {
  final String slotId;
  final String stationName;

  const Booking({super.key, required this.slotId, required this.stationName});

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
        create: (context) => BookingViewModel(
          usersRepository: context.read<UsersRepository>(),
          bookingRepository: context.read<BookingRepository>(),
          bikeSlotRepository: context.read<BikeSlotRepository>(),
          slotId: slotId,
          stationName: stationName,
        ),
        child: const BookingContent(),
      ),
    );
  }
}
