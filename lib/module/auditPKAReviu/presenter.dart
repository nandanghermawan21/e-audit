import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_pa_model.dart';
import 'package:eaudit/model/audit_pka_model.dart';
import 'package:eaudit/model/program_audit_model.dart';
import 'package:eaudit/util/error_handling_util.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final VoidCallback? onSubmitSuccess;
  final AuditPaModel? auditPA;

  const Presenter({
    Key? key,
    this.auditPA,
    this.onSubmitSuccess,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ListDataComponentController<ProgramAuditModel> listController =
      ListDataComponentController<ProgramAuditModel>();
  CircularLoaderController loadingController = CircularLoaderController();

  void submitReviu() {
    //validasi
    if (listController.value.data.where((e) => e.approve == null).isNotEmpty) {
      loadingController.stopLoading(
        isError: true,
        message: "harap isi semua status reviu",
      );
      return;
    }

    if (listController.value.data
        .where((e) => e.catatan == null || e.catatan == "")
        .isNotEmpty) {
      loadingController.stopLoading(
        isError: true,
        message: "harap isi semua catatan reviu",
      );
      return;
    }

    loadingController.startLoading();
    AuditPKAModel.postReviu(
      token: System.data.global.token,
      assignedId: widget.auditPA!.id,
      paModel: listController.value.data,
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
