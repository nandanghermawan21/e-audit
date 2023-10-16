import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:eaudit/recource/color_default.dart';
import 'package:eaudit/recource/font_default.dart';
import 'package:eaudit/recource/string_id_id.dart';
import 'package:eaudit/route.dart';
import 'package:eaudit/util/api_end_point.dart';
import 'package:eaudit/util/data.dart';
import 'package:eaudit/util/enum.dart';
import 'package:eaudit/util/mode_util.dart';
import 'package:eaudit/util/one_signal_messaging.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:eaudit/route.dart' as route;

void setting() {
  System.data.versionName = "2.0.15";
  System.data.global.token = "MjAyMi0wNC0yMCAxMDowNjozMd6DKZ6cWXLIY-DODMQD37A";
  System.data.route = route.route;
  System.data.apiEndPoint = ApiEndPoint();
  System.data.strings = StringsIdId();
  System.data.color = ColorDefault();
  System.data.font = FontDefault();
  //change end point on dev mode
  if (System.data.versionName.split(".")[1] == "1") {
    System.data.apiEndPoint.baseUrl =
        "http://dev-jamkrindo.banggasolution.com/Api/";
    System.data.apiEndPoint.baseUrlDebug =
        "http://dev-jamkrindo.banggasolution.com/Api/";
  } else {
    if (System.data.versionName.split(".")[1] == "2") {
      System.data.apiEndPoint.baseUrl =
          "https://api-eaudit.jamkrindo.co.id/Api";
      System.data.apiEndPoint.baseUrlDebug =
          "https://api-eaudit.jamkrindo.co.id/Api";
      System.data.global.token =
          "MjAyMi0wNC0yMCAxMDowNjozMd6DKZ6cWXLIY-DODMQD37A";
      System.data.global.urlEaudit = "https://eaudit.jamkrindo.co.id/";
    }
  }
  //setting permisson [haru didefinisikan juga pada manifest dan info.pls]
  System.data.permission = [
    Permission.accessNotificationPolicy,
    Permission.location,
    Permission.camera,
  ];
  //setting oneSignal notification
  if (kIsWeb == false) {
    System.data.oneSignalMessaging = OneSignalMessaging(
      appId:
          "d94c96d3-2b89-47e6-9fd0-3a4530a935a2", //e6286e77-62fe-45f1-add6-5dbe06d5db3b
      notificationHandler: (notification) {
        ModeUtil.debugPrint("notification notificationHandler fire");
      },
      notificationOpenedHandler: (notification) {
        ModeUtil.debugPrint("notification notificationOpenedHandler fire");
      },
      notificationClickedHandler: (notification) {
        ModeUtil.debugPrint("notification notificationClickedHandler fire");
      },
    );
  }
  //subscribe chanel
  System.data.oneSignalMessaging!.sendTag("specialUser", true);
  System.data.deepLinkingHandler = (uri) {
    ModeUtil.debugPrint(uri?.path ?? "");
    if (ModalRoute.of(System.data.context)?.settings.name == initialRouteName) {
      return;
    }
    switch (uri?.path) {
      default:
        return;
    }
  };
  System.data.onCreateDb = (db, version) {
    int last = 0;
    for (int i = version; i < last; i++) {
      rootBundle.loadString("dbmigration/dbv${i + 1}.sql").then((sql) {
        db?.execute(sql).then((v) {
          db.setVersion(i + 1).then((v) {
            ModeUtil.debugPrint("update to version ${i + 1}");
          });
        });
      });
      ModeUtil.debugPrint("update is uptodate");
    }
  };
  System.data.onOnesignalCreated = () {
    if (System.data.global.user?.userId != null) {
      System.data.oneSignalMessaging
          ?.setExternalUserId(System.data.global.user!.userId!);
    }
  };
  System.data.directories = {
    DirKey.collection: "collection",
    DirKey.inbox: "inbox",
    DirKey.process: "process",
    DirKey.upload: "upload",
    DirKey.images: "images",
  };
  System.data.files = {
    FileKey.collection: FileInit(
      dirKey: DirKey.collection,
      name: "collection.json",
      value: "[]",
    ),
  };
}
