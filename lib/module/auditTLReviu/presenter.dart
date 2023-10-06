import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final AuditTLReviuModel? auditTLReviu;
  final ValueChanged2Param<String?, String?>? onTapFile;
  final VoidCallback? onSubmitSuccess;

  const Presenter({
    Key? key,
    this.view,
    this.auditTLReviu,
    this.onTapFile,
    this.onSubmitSuccess,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  CircularLoaderController loadingController = CircularLoaderController();
}
