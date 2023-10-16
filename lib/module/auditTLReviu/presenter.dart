import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_tl_item_model.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/util/error_handling_util.dart';
import 'package:eaudit/util/system.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final AuditTLReviuModel? auditTLReviu;
  final ValueChanged2Param<String?, String?>? onTapFile;
  final VoidCallback? onSubmitSuccess;
  final String type;

  const Presenter({
    Key? key,
    this.view,
    this.auditTLReviu,
    this.onTapFile,
    this.onSubmitSuccess,
    required this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  TextEditingController catatanController = TextEditingController();
  CircularLoaderController loadingController = CircularLoaderController();

  void postReviu(String? status) {
    loadingController.startLoading();
    AuditTLItemModel.postReviu(
      token: System.data.global.token,
      tlId:
          widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi?.first?.listItem?.first?.id ??
              "",
      note: catatanController.text,
      status: status,
      type: type,
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

  String get type {
    switch (widget.type) {
      case "data_tl_internal":
        return "post_reviu_tindaklanjut_internal";
      case "data_tl_eksternal":
        return "post_reviu_tindaklanjut_external";
      case "data_tl_management_letter":
        return "post_reviu_tindaklanjut_ml";
      default:
        return "post_reviu_tindaklanjut_internal";
    }
  }
}
