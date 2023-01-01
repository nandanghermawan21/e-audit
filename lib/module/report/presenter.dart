import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/report_model.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final ValueChanged2Param<String?, String?> onTapDocument;

  const Presenter({
    super.key,
    required this.onTapDocument,
  });

  @override
  State<StatefulWidget> createState() {
    return View();
  }
}

abstract class PresenterState extends State<Presenter> {
  int selectedYear = DateTime.now().year;
  ListDataComponentController<ReportModel> listController =
      ListDataComponentController<ReportModel>();
}
