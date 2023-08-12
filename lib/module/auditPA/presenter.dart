import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_pa_model.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final String type;
  final ValueChanged<AuditPaModel?>? onTapItem;

  const Presenter({
    Key? key,
    this.view,
    required this.type,
    this.onTapItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<AuditPaModel> listController =
      ListDataComponentController<AuditPaModel>();
}