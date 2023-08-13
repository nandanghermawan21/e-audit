import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  AuditTLReviuModel? auditTLReviuModel;

  void commit() {
    notifyListeners();
  }
}
