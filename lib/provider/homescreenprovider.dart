import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  bool _hiringclicked = false;
  bool get hiringclicked => _hiringclicked;
  set hiringclicked(value) {
    _hiringclicked = value;
    notifyListeners();
  }

  bool _lookingjobsclicked = false;
  bool get lookingjobsclicked => _lookingjobsclicked;
  set lookingjobsclicked(value) {
    _lookingjobsclicked = value;
    notifyListeners();
  }
}
