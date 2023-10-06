import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final AuditTLReviuModel? auditTLReviu;
  final ValueChanged<AuditTLReviuModel> onSelectAction;

  const Presenter({
    Key? key,
    this.view,
    this.auditTLReviu,
    required this.onSelectAction,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  CircularLoaderController loadingController = CircularLoaderController();
}
