import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:flutter/material.dart';
import '../../model/audit_pka_reviu_model.dart';
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
  ListDataComponentController<AuditPKAReviuModel> listController =
      ListDataComponentController<AuditPKAReviuModel>();
  CircularLoaderController loadingController = CircularLoaderController();
}
