import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/pass.dart';

class BookingViewModel extends ChangeNotifier {
  // State
  bool _hasPass = false;
  Pass? _pass;

  // Getters
  bool get hasPass => _hasPass;
  Pass? get pass => _pass;

  /// TODO: fetch current user and read their activePass field
  Future<void> checkActivePass() async {}

  /// TODO: create booking via BookingRepository
  Future<void> confirmBooking() async {}

  /// TODO: update booking status via BookingRepository
  Future<void> releaseBike() async {}

  /// Called by View when user returns from SubscriptionsScreen with a purchased pass
  void onPassPurchased(Pass pass) {
    _hasPass = true;
    _pass = pass;
    notifyListeners();
  }
}
