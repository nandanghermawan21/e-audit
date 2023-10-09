import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier{
  int selectedYear = DateTime.now().year;
  TextEditingController searchController = TextEditingController();

  bool isGetNewData = false;

  void commit(){
    notifyListeners();
  }
}