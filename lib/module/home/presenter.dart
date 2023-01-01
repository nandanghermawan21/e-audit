import 'dart:async';

import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/check_access_model.dart';
import 'package:eaudit/model/realisasi_model.dart';
import 'package:eaudit/util/error_handling_util.dart';
import 'package:eaudit/util/system.dart';
import 'package:eaudit/util/type.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final VoidCallback onTapLogout;
  final ValueChanged2Param onTapUrl;
  final VoidCallback onTapManualBook;
  final VoidCallback onTapReport;
  final VoidCallback onTapReviewTask;

  const Presenter({
    super.key,
    required this.onTapLogout,
    required this.onTapUrl,
    required this.onTapManualBook,
    required this.onTapReport,
    required this.onTapReviewTask,
  });

  @override
  State<StatefulWidget> createState() {
    return View();
  }
}

abstract class PresenterState extends State<Presenter> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CircularLoaderController loadingController = CircularLoaderController();
  final dataRealisasiStream = StreamController<RealisasiModel?>();

  @override
  void initState() {
    super.initState();
    getRealisasiData();
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void logout() {
    loadingController.stopLoading(
      isError: true,
      icon: Icon(
        FontAwesomeIcons.questionCircle,
        color: System.data.color?.warningColor,
        size: 50,
      ),
      messageWidget: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.transparent,
              child: Text(
                "${System.data.global.user?.userUsername}, Apakah anda yakin akan keluar?",
                style: System.data.textStyles!.basicLabel,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        System.data.color!.dangerColor)),
                onPressed: () {
                  widget.onTapLogout();
                },
                child: Text(
                  "Keluar",
                  style: System.data.textStyles!.basicLabel.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getRealisasiData() {
    dataRealisasiStream.add(null);
    RealisasiModel.get(
      token: System.data.global.token,
      tahun: DateTime.now().year,
    ).then((value) {
      dataRealisasiStream.add(value);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  void checkAccess({
    String? method,
    VoidCallback? onGrandted,
  }) {
    loadingController.startLoading();
    CheckAccessModel.get(
      token: System.data.global.token,
      group: System.data.global.user?.groupId,
      method: method,
    ).then(
      (value) {
        if (value == true) {
          loadingController.forceStop();
          onGrandted!();
        } else {
          loadingController.stopLoading(
            icon: const Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: Colors.red,
              size: 35,
            ),
            message: "Anda tak memiliki akses ke menu ini!",
          );
        }
      },
    ).catchError((onError) {
      loadingController.stopLoading(
        message: ErrorHandlingUtil.handleApiError(onError),
      );
    });
  }
}
