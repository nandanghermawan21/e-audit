import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier{
  int selectedYear = DateTime.now().year;

  void commit(){
    notifyListeners();
  }
}