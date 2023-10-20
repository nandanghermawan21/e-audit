import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_notifikasi_model.dart';
import 'package:eaudit/model/audit_rekomendasi_model.dart';
import 'package:eaudit/model/audit_tl_model.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/util/error_handling_util.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final AuditNotificationModel? openNotification;
  final ValueChanged<AuditTLReviuModel?>? onOpenAuditTl;

  const Presenter(
      {Key? key, this.openNotification, this.onOpenAuditTl})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> with SingleTickerProviderStateMixin {
  CircularLoaderController loadingController = CircularLoaderController();
  ListDataComponentController<AuditNotificationModel>
      listDataComponentController =
      ListDataComponentController<AuditNotificationModel>();
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    if (widget.openNotification != null) {
      openNotification(widget.openNotification);
    }
  }

  void openNotification(AuditNotificationModel? notification) {
    switch (notification?.notificationType) {
      case "matrikstindaklanjut_ml":
        openAuditTl(
            type: "data_tl_management_letter_detail",
            rekomendasiId: notification?.notificationDataId);
        break;
      case "matrikstindaklanjut":
        openAuditTl(
            type: "data_tl_internal_detail",
            rekomendasiId: notification?.notificationDataId);
        break;
      default:
    }
  }

  void openAuditTl({
    required String? type,
    required String? rekomendasiId,
  }) {
    loadingController.startLoading();
    AuditRekomendasiModel.get(
            token: System.data.global.token,
            method: type,
            rekomendasiId: rekomendasiId)
        .then(
      (value) {
        loadingController.forceStop();
        widget.onOpenAuditTl?.call(
          AuditTLReviuModel(
            listAuditTL: [
              AuditTLModel(
                noTemuan: value.first.findingNo ,
                judulTemuan: value.first.findingJudul,
                listRekomendasi: value,
              )
            ],
          ),
        );
      },
    ).catchError(
      (onError) {
        loadingController.stopLoading(
          isError: true,
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      },
    );
  }
}
