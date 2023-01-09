import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/review_task_model.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  const Presenter({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return View();
  }
}

abstract class PresenterState extends State<Presenter> {
  int? selectedYear;
  ListDataComponentController<ReviewTaskModel> listController =
      ListDataComponentController<ReviewTaskModel>();
}
