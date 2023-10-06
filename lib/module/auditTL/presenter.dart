import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final ValueChanged<AuditTLReviuModel?>? onSelectItem;

  const Presenter({
    Key? key,
    this.view,
    this.onSelectItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<AuditTLReviuModel> listDataComponentController =
      ListDataComponentController<AuditTLReviuModel>();
}
