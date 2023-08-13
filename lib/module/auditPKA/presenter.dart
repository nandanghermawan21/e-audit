import 'package:eaudit/model/audit_kka_model.dart';
import 'package:eaudit/model/audit_pka_model.dart';
import 'package:flutter/material.dart';
import '../../component/list_data_component.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final ValueChanged<AuditPKAModel?>? onTapReviu;
  final ValueChanged<AuditKKAModel?>? onTapKKA;

  const Presenter({
    Key? key,
    this.view,
    this.onTapReviu,
    this.onTapKKA,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<AuditPKAModel> listController =
      ListDataComponentController<AuditPKAModel>();
}
