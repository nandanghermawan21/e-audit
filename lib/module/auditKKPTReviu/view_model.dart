import 'package:eaudit/model/audit_kkpt_reviu_model.dart';
import 'package:flutter/material.dart';

class ViewMOdel extends ChangeNotifier {
  AuditKKPTReviuModel? kkpt;

  void commit() {
    notifyListeners();
  }
}
