import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_tl_model.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'view_model.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final AuditTLReviuModel? auditTLReviu;
  final ValueChanged2Param<String?, String?>? onTapFile;
  final VoidCallback? onSubmitSuccess;
  final ValueChanged<AuditTLReviuModel?>? onSelectAction;

  const Presenter({
    Key? key,
    this.view,
    this.auditTLReviu,
    this.onTapFile,
    this.onSubmitSuccess,
    this.onSelectAction,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = ViewModel();
  CircularLoaderController loadingController = CircularLoaderController();
  ListDataComponentController<AuditTLModel> listDataComponentController =
      ListDataComponentController<AuditTLModel>();

  @override
  initState() {
    super.initState();
    model.auditTLReviuModel = widget.auditTLReviu;
  }
}
