import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_tl_model.dart';
import 'package:flutter/cupertino.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter>? view;

  const Presenter({Key? key, this.view}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<AuditTLModel> listDataComponentController =
      ListDataComponentController<AuditTLModel>();
}
