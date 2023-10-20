import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  const Presenter({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  int? selectedYear;
  ListDataComponentController<String> listController =
      ListDataComponentController<String>();

  CircularLoaderController loaderController = CircularLoaderController();

  Future<List<String>> getListDashboard() {
    return Future.value().then((value) {
      return [
        "realisasi",
        "realisasiBulanan",
        "auditRatingTemuan",
        "auditRatingUnitKerja",
        "temuanPerUnitKerja",
        "monitoringTindakLanjut",
        (System.data.global.user?.groupName ?? "").toLowerCase() != "direksi"
            ? "monitoringTindakLanjutManagementLetter"
            : "",
        "monitoringWxternal",
      ];
    });
  }

  @override
  void dispose() {
    System.data.getNotifikasiData(System.data.global.token ?? "");
    super.dispose();
  }
}
