import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_pa_model.dart';
import 'package:eaudit/model/program_audit_model.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final VoidCallback? onSubmitSuccess;
  final AuditPaModel? auditPA;

  const Presenter({
    Key? key,
    this.auditPA,
    this.onSubmitSuccess,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<ProgramAuditModel> listController =
      ListDataComponentController<ProgramAuditModel>();
  CircularLoaderController loadingController = CircularLoaderController();
}
