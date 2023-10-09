import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_kka_model.dart';
import 'package:eaudit/model/audit_kka_reviu_model.dart';
import 'package:eaudit/util/error_handling_util.dart';
import 'package:eaudit/util/system.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final AuditkaReviuModel? kka;
  final VoidCallback? onSubmitSuccess;
  final ValueChanged2Param<String, String>? onTapDocument;

  const Presenter(
      {Key? key, this.view, this.kka, this.onSubmitSuccess, this.onTapDocument})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  CircularLoaderController loadingController = CircularLoaderController();
  TextEditingController noteController = TextEditingController();

  //buat function untuk mengitung selisih waktu denga saat ini untuk menunjukan kapan komentar di posting
  String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 365) {
      return '${(diff.inDays / 365).floor()} tahun yang lalu';
    } else if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()} bulan yang lalu';
    } else if (diff.inDays > 7) {
      return '${(diff.inDays / 7).floor()} minggu yang lalu';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} hari yang lalu';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} jam yang lalu';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} menit yang lalu';
    } else {
      return 'baru saja';
    }
  }

  void postReviu(String? status) {
    loadingController.startLoading();
    AuditKKAModel.postReviu(
      token: System.data.global.token,
      kkaId: widget.kka?.listKka?.first?.id ?? "",
      note: noteController.text,
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
