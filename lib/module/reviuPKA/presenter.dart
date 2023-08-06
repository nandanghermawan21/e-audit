import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:flutter/material.dart';
import '../../model/reviu_pka_model.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final VoidCallback? onSubmitSuccess;

  const Presenter({
    Key? key,
    this.onSubmitSuccess,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<ReviuPkaModel> listController =
      ListDataComponentController<ReviuPkaModel>();
  CircularLoaderController loadingController = CircularLoaderController();
}
