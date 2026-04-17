import 'package:flutter/material.dart';
import 'package:g4_t1_velo_app/model/station.dart';

class SelectedStation with ChangeNotifier {
  Station? _value;

  Station? get value => _value;

  bool isSelected(Station station) => _value?.id == station.id;

  void select(Station station) {
    if (_value?.id == station.id) {
      return;
    }
    _value = station;
    notifyListeners();
  }

  void clear() {
    if (_value == null) {
      return;
    }
    _value = null;
    notifyListeners();
  }
}
