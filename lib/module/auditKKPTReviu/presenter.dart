import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_kkpt_reviu_model.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'view_model.dart';

import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final AuditKKPTReviuModel? kkpt;
  final VoidCallback? onSubmitSuccess;
  final ValueChanged2Param<String?, String?>? onTapFile;

  const Presenter(
      {Key? key, this.view, this.kkpt, this.onSubmitSuccess, this.onTapFile})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewMOdel model = ViewMOdel();
  CircularLoaderController loadingController = CircularLoaderController();

  @override
  void initState() {
    model.kkpt = widget.kkpt;
    super.initState();
  }
}
