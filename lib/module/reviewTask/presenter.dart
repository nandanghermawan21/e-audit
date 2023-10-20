import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/review_task_model.dart';
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
  ListDataComponentController<ReviewTaskModel> listController =
      ListDataComponentController<ReviewTaskModel>();

  @override
  void dispose() {
    System.data.getNotifikasiData(System.data.global.token ?? "");
    super.dispose();
  }
}
