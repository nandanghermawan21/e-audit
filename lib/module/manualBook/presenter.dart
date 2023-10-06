import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/manual_book_model.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final ValueChanged2Param<String, String> onTapItem;

  const Presenter({
    Key? key,
    required this.onTapItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
  //
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<ManualBookModel> listController =
      ListDataComponentController<ManualBookModel>();
}
