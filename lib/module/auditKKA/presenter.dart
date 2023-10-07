import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_kka_reviu_model.dart';
import 'package:eaudit/model/audit_pa_model.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final AuditPaModel? auditPA;
  final ValueChanged<AuditkaReviuModel?>? onSelectAction;

  const Presenter({
    Key? key,
    this.view,
    this.auditPA,
    this.onSelectAction,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<AuditkaReviuModel> listController =
      ListDataComponentController<AuditkaReviuModel>();
  CircularLoaderController loadingController = CircularLoaderController();
}
