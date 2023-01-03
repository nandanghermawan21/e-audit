import 'package:eaudit/component/list_data_component.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  const Presenter({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return View();
  }
}

abstract class PresenterState extends State<Presenter> {
  int? selectedYear;
  ListDataComponentController<String> listController =
      ListDataComponentController<String>();

  Future<List<String>> getListDashboard() {
    return Future.value().then((value) {
      return [
        "realisasi",
        "realisasiBulanan",
        "auditRatingTemuan",
        "auditRatingUnitKerja",
        "temuanPerUnitKerja",
        "monitoringTindakLanjut",
        "monitoringTindakLanjutManagementLetter",
        "monitoringWxternal",
      ];
    });
  }
}
