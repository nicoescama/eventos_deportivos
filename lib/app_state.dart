import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {

  String selectedCategoryId = "";

  void updateCategoryId(String selectedCategoryId) {
    this.selectedCategoryId  = selectedCategoryId;
    notifyListeners();
  }
}