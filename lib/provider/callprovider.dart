import 'dart:io';

import 'package:flutter/material.dart';

class CallProvider extends ChangeNotifier {
  final _hiringFormKey = GlobalKey<FormState>();
  get hiringFormKey => _hiringFormKey;
  final _lookingforjobsFormKey = GlobalKey<FormState>();
  get lookingforjobsFormKey => _lookingforjobsFormKey;

  String _country = 'Canada';
  String get country => _country;
  set country(String value) {
    _country = value;
    notifyListeners();
  }

  File? _image;
  File? get image => _image;
  set image(File? value) {
    _image = value;
    notifyListeners();
  }

  String _skill = '';
  String get skill => _skill;
  set skill(String value) {
    _skill = value;
    notifyListeners();
  }
}
