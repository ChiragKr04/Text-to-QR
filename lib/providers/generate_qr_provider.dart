import 'package:flutter/material.dart';

class GenerateQrProvider extends ChangeNotifier {
  bool isQrInit = false;
  String currentData = "";

  void generateQr(String data) {
    currentData = data;
    isQrInit = true;
    notifyListeners();
  }
}
