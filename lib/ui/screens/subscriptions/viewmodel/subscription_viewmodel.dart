import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/data/repositories/pass/pass_repository.dart';
import 'package:g4_t1_velo_app/model/pass.dart';
import 'package:g4_t1_velo_app/ui/utils/async_value.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final PassRepository _passRepository;

  SubscriptionViewModel(this._passRepository) {
    _init();
  }

  AsyncValue<List<Pass>> _passValue = AsyncValue.loading();
  int _selectedIndex = 0;

  AsyncValue<List<Pass>> get passValue => _passValue;
  int get selectedIndex => _selectedIndex;

  Pass? get selectedPass {
    if (_passValue.state == AsyncValueState.success) {
      return _passValue.data![_selectedIndex];
    }
    return null;
  }

  void _init() {
    loadPasses();
  }

  Future<void> loadPasses() async {
    _passValue = AsyncValue.loading();
    notifyListeners();
    try {
      final passes = await _passRepository.getPasses();
      _passValue = AsyncValue.success(passes);
    } catch (e) {
      _passValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void selectPass(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
