import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_rekomendasi_model.dart';
import 'package:eaudit/model/audit_tl_model.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/util/error_handling_util.dart';
import 'package:eaudit/util/system.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'view_model.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final AuditTLReviuModel? auditTLReviu;
  final ValueChanged2Param<String?, String?>? onTapFile;
  final VoidCallback? onSubmitSuccess;
  final ValueChanged<AuditTLReviuModel?>? onSelectAction;
  final String type;

  const Presenter({
    Key? key,
    this.view,
    this.auditTLReviu,
    this.onTapFile,
    this.onSubmitSuccess,
    this.onSelectAction,
    required this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = ViewModel();
  TextEditingController catatanController = TextEditingController();
  CircularLoaderController loadingController = CircularLoaderController();
  ListDataComponentController<AuditTLModel> listDataComponentController =
      ListDataComponentController<AuditTLModel>();

  @override
  initState() {
    super.initState();
    model.auditTLReviuModel = widget.auditTLReviu;
  }

   void postReviu(String? statusNumber, String? status) {
    loadingController.startLoading();
    AuditRekomendasiModel.postReviu(
      token: System.data.global.token,
      rekomendasiId: widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi?.first?.id ?? "",
      note: catatanController.text,
      status: statusNumber,
      type: type,
    ).then((value) {
      loadingController.stopLoading(
        message: "Data Berhasil Tersimpan",
        isError: false,
        duration: const Duration(seconds: 3),
        onCloseCallBack: () {
          model.auditTLReviuModel?.listAuditTL?.first?.listRekomendasi?.first?.rekomendasiStatusNumber = statusNumber;
          model.auditTLReviuModel?.listAuditTL?.first?.listRekomendasi?.first?.statusRekomendasi = status;
          model.commit();
        },
      );
    }).catchError((onError) {
      loadingController.stopLoading(
        isError: true,
        message: ErrorHandlingUtil.handleApiError(onError),
      );
    });
  }

  String get type{
    switch (widget.type) {
      case "data_tl_internal":
        return "post_reviu_rekomendasi_internal";
      case "data_tl_eksternal":
        return "post_reviu_rekomendasi_external";
      case "data_tl_management_letter":
        return "post_reviu_rekomendasi_ml";
      default:
        return "post_reviu_rekomendasi_internal";
    }
  }
}
