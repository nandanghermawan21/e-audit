import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_kkpt_model.dart';
import 'package:eaudit/model/audit_kkpt_reviu_model.dart';
import 'package:eaudit/util/error_handling_util.dart';
import 'package:eaudit/util/system.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

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
    return view ?? main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  TextEditingController catatanController = TextEditingController();
  CircularLoaderController loadingController = CircularLoaderController();
  double width = 0;

  @override
  void initState() {
    super.initState();
  }

  void postReviu(String? status) {
    loadingController.startLoading();
    AuditKKPTModel.postReviu(
      token: System.data.global.token,
      findingId: widget.kkpt?.listKKPT?.first?.id ?? "",
      note: catatanController.text,
      status: status,
    ).then((value) {
      loadingController.stopLoading(
        message: "Data Berhasil Tersimpan",
        isError: false,
        duration: const Duration(seconds: 3),
        onCloseCallBack: () {
          widget.onSubmitSuccess?.call();
        },
      );
    }).catchError((onError) {
      loadingController.stopLoading(
        isError: true,
        message: ErrorHandlingUtil.handleApiError(onError),
      );
    });
  }
}
