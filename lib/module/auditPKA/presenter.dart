import 'package:eaudit/model/audit_pa_model.dart';
import 'package:eaudit/model/audit_pka_model.dart';
import 'package:flutter/material.dart';
import '../../component/list_data_component.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final AuditPaModel? auditPA;
  final ValueChanged<AuditPaModel?>? onTapReviu;
  final ValueChanged<AuditPaModel?>? onTapKKA;

  const Presenter({
    Key? key,
    this.view,
    this.auditPA,
    this.onTapReviu,
    this.onTapKKA,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<AuditPKAModel> listController =
      ListDataComponentController<AuditPKAModel>();
}
