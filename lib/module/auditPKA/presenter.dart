import 'package:eaudit/component/circular_loader_component.dart';
// import 'package:eaudit/model/audit_kka_model.dart';
import 'package:eaudit/model/audit_pa_model.dart';
import 'package:eaudit/model/audit_pka_model.dart';
// import 'package:eaudit/util/error_handling_util.dart';
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
  CircularLoaderController loaderController = CircularLoaderController();
  ListDataComponentController<AuditPKAModel> listController =
      ListDataComponentController<AuditPKAModel>();

  // void onTapKKa(String kkaId) {
  //   loaderController.startLoading();
  //   AuditKKAModel.get(
  //     token: "System.data.global.token",
  //     kkaId: kkaId,
  //   ).then((value) {
  //     loaderController.forceStop();
  //     widget.onTapKKA?.call(value);
  //   }).catchError((onError){
  //     loaderController.stopLoading(
  //       isError: true,
  //       message: ErrorHandlingUtil.defaultMessage(onError),
  //     );
  //   });
  // }
}
