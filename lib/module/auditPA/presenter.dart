import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_pa_model.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;
import 'view_model.dart';

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final String type;
  final int tahun;
  final ValueChanged<AuditPaModel?>? onTapItem;

  const Presenter({
    Key? key,
    this.view,
    required this.type,
    required this.tahun,
    this.onTapItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = ViewModel();
  ListDataComponentController<AuditPaModel> listController =
      ListDataComponentController<AuditPaModel>();

  @override
  void initState() {
    super.initState();
    debugPrint("selected tahun ${widget.tahun}");
    model.selectedYear = widget.tahun;
  }
}
