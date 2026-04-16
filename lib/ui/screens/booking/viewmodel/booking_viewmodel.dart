import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/data/repositories/bike_slot/bike_slot_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/booking/booking_repository.dart';
import 'package:g4_t1_velo_app/data/repositories/users/users_repository.dart';
import 'package:g4_t1_velo_app/model/bike_slot.dart';
import 'package:g4_t1_velo_app/model/booking.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:g4_t1_velo_app/model/users.dart';
import 'package:g4_t1_velo_app/ui/utils/async_value.dart';

class BookingViewModel extends ChangeNotifier {
  final UsersRepository _usersRepository;
  final BookingRepository _bookingRepository;
  final BikeSlotRepository _bikeSlotRepository;
  final String slotId;

  // Hardcoded for demo — replace with auth user id when auth is implemented
  static const String _mockUserId = 'user_mock_1';

  BookingViewModel(
    this._usersRepository,
    this._bookingRepository,
    this._bikeSlotRepository,
    this.slotId,
  ) {
    _init();
  }

  AsyncValue<BikeSlot> _slotValue = AsyncValue.loading();
  AsyncValue<Pass?> _activePassValue = AsyncValue.loading();
  AsyncValue<String?> _currentBookingIdValue = AsyncValue.loading();
  AsyncValue<Booking>? _confirmValue;

  AsyncValue<BikeSlot> get slotValue => _slotValue;
  AsyncValue<Pass?> get activePassValue => _activePassValue;
  AsyncValue<Booking>? get confirmValue => _confirmValue;

  BikeSlot? get slot => _slotValue.data;

  Pass? get activePass =>
      _activePassValue.state == AsyncValueState.success
          ? _activePassValue.data
          : null;

  bool get hasPass => activePass != null;

  bool get hasActiveBooking =>
      _currentBookingIdValue.state == AsyncValueState.success &&
      _currentBookingIdValue.data != null;

  bool get isInitializing =>
      _slotValue.state == AsyncValueState.loading ||
      _activePassValue.state == AsyncValueState.loading ||
      _currentBookingIdValue.state == AsyncValueState.loading;

  bool get hasInitError =>
      !isInitializing &&
      (_slotValue.state == AsyncValueState.error ||
          _activePassValue.state == AsyncValueState.error ||
          _currentBookingIdValue.state == AsyncValueState.error);

  void _init() {
    loadSlot();
    checkActivePass();
    checkCurrentBooking();
  }

  Future<void> retry() async {
    await Future.wait([loadSlot(), checkActivePass(), checkCurrentBooking()]);
  }

  Future<void> loadSlot() async {
    _slotValue = AsyncValue.loading();
    notifyListeners();
    try {
      final slot = await _bikeSlotRepository.getSlot(slotId);
      _slotValue = AsyncValue.success(slot);
    } catch (e) {
      _slotValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> checkActivePass() async {
    _activePassValue = AsyncValue.loading();
    notifyListeners();
    try {
      final pass = await _usersRepository.getActivePass(_mockUserId);
      _activePassValue = AsyncValue.success(pass);
    } catch (e) {
      _activePassValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> checkCurrentBooking() async {
    _currentBookingIdValue = AsyncValue.loading();
    notifyListeners();
    try {
      final bookingId = await _usersRepository.getCurrentBookingId(_mockUserId);
      _currentBookingIdValue = AsyncValue.success(bookingId);
    } catch (e) {
      _currentBookingIdValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> confirmBooking() async {
    _confirmValue = AsyncValue.loading();
    notifyListeners();
    try {
      // Prevent booking if user already has an active booking
      if (hasActiveBooking) {
        _confirmValue = AsyncValue.error('You already have an active booking');
        notifyListeners();
        return;
      }

      // Re-fetch slot to catch bikes booked by another user while on this screen
      final slot = await _bikeSlotRepository.getSlot(slotId);

      if (slot.status != SlotStatus.available) {
        _confirmValue = AsyncValue.error('Bike is no longer available');
        notifyListeners();
        return;
      }

      final pass = activePass ?? Pass.singleTrip();

      final booking = await _bookingRepository.createBooking(
        Booking(
          id: '',
          user: Users(id: _mockUserId, activePass: activePass),
          slot: slot,
          pass: pass,
          start: DateTime.now(),
        ),
      );

      await _usersRepository.updateCurrentBookingId(_mockUserId, booking.id);
      _currentBookingIdValue = AsyncValue.success(booking.id);
      _confirmValue = AsyncValue.success(booking);
    } catch (e) {
      _confirmValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> onPassPurchased(Pass pass) async {
    _activePassValue = AsyncValue.success(pass);
    notifyListeners();
    await _usersRepository.updateActivePass(_mockUserId, pass);
  }
}
