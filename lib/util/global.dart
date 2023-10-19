import 'dart:async';

import 'package:eaudit/model/audit_notifikasi_model.dart';
import 'package:eaudit/model/user_model.dart';

class Global {
  String? token = "";
  String? messagingToken;
  Uri? currentDeepLinkUri;
  UserModel? user;
  String urlEaudit = "https://jamkrindo.banggasolution.com/";
  String notifAppId = "5950883a-0066-4be7-ac84-3d240982ffaf";
  String notifAppKey = "63773c22-a638-49a1-b538-440bdd3b7975";
  final dataNotifikasiStream = StreamController<String?>();

  void getNotifikasiData() {
    // dataNotifikasiStream.add(null);
    AuditNotificationModel.count(
      token: token,
    ).then((value) {
      dataNotifikasiStream.add(value ?? "");
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  Global();
}
