import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:eaudit/util/api_end_point.dart';
import 'package:eaudit/util/colour.dart';
import 'package:eaudit/util/databases.dart';
import 'package:eaudit/util/font.dart';
import 'package:eaudit/util/strings.dart';
import 'package:eaudit/util/mode_util.dart';
import 'package:eaudit/util/one_signal_messaging.dart';
import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/util/text_style.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'global.dart';

class Data extends ChangeNotifier {
  String versionName = "2.0.6";
  int versionCode = 0;
  String copyrightName = "E-Audit Jamkrindo \u00A9 2023";
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  CircularLoaderController loadingController = CircularLoaderController();
  bool sendToBackGround = true;

  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;

  Map<String, WidgetBuilder>? route;
  bool resizeToAvoidBottomInset = false;

  VoidCallback? onUnAuthorized;
  BuildContext get context => navigatorKey.currentContext!;
  ApiEndPoint apiEndPoint = ApiEndPoint();
  Global global = Global();
  Strings? strings;
  Colour? color;
  Font? font;
  TextStyles? textStyles = TextStyles();
  OneSignalMessaging? oneSignalMessaging;
  VoidCallback? onOnesignalCreated = () {};
  List<Permission> permission = [];
  ValueChanged<Uri?>? deepLinkingHandler;
  SharedPreferences? session;
  Databases? database;
  Function(Database?, int)? onCreateDb;
  ValueChanged<Map<String, dynamic>?>? onServiceDataReceived;
  Directory? appDirectory;
  Map<String, String> directories = {};
  Map<String, FileInit> files = {};
  DeviceInfo? deviceInfo;

  Data();

  Future<void> initialize() async {
    await _initSharedPreference();
    await _initDatabse();
    await _initDeviceInfo();
    appDirectory = await getApplicationDocumentsDirectory();
    deviceInfo = await initDeviceInfo();
    initDirectories();
    iniFiles();
  }

  void commit() {
    notifyListeners();
  }

  Future<bool> _initSharedPreference() async {
    session = await SharedPreferences.getInstance();
    return true;
  }

  Future<bool> _initDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      iosInfo = await deviceInfo.iosInfo;
    }
    return true;
  }

  Future<bool> _initDatabse() async {
    database = await Databases().initializeDb(
      onCreate: (db, version) {
        ModeUtil.debugPrint("Database information :");
        ModeUtil.debugPrint("path                 : ${db?.path}");
        ModeUtil.debugPrint("version              : $version");
        if (onCreateDb != null) {
          onCreateDb!(db, version);
        }
      },
    );
    return true;
  }

  Future<bool> reInitDatabase() async {
    database = await Databases().initializeDb(
      deleteOldDb: true,
      onCreate: (db, version) {
        ModeUtil.debugPrint("Reinit Database information :");
        ModeUtil.debugPrint("path                 : ${db?.path}");
        ModeUtil.debugPrint("version              : $version");
        if (onCreateDb != null) {
          onCreateDb!(db, version);
        }
      },
    );
    return true;
  }

  void initDirectories() {
    for (var dir in directories.values) {
      Directory filePath = Directory('${appDirectory?.path}/$dir');

      if (!filePath.existsSync()) {
        filePath.createSync(recursive: true);
      }
    }
  }

  Directory getDir(String dirKey) {
    return Directory(
        "${appDirectory?.path ?? ""}/${directories[dirKey] ?? ""}");
  }

  void iniFiles() {
    for (var file in files.values) {
      File filePath = File("${getDir(file.dirKey).path}/${file.name}");

      if (!filePath.existsSync()) {
        filePath.createSync(recursive: true);
        filePath.writeAsStringSync(file.value);
      }
    }
  }

  File? getFile(String fileKey) {
    FileInit? file = files[fileKey];

    if (file == null) return null;

    return File("${getDir(file.dirKey).path}/${file.name}");
  }

  Future<DeviceInfo> initDeviceInfo() {
    return Future.value().then((value) {
      return DeviceInfo(
        imei: value,
        deviceId:
            Platform.isAndroid ? androidInfo?.id : iosInfo?.identifierForVendor,
        deviceModel: Platform.isAndroid
            ? ("${androidInfo?.model} ${androidInfo?.device}").toUpperCase()
            : iosInfo?.model,
      );
    });

    // return DeviceInfo(
    //   imei: await UniqueIdentifier.serial,
    //   deviceId:
    //       Platform.isAndroid ? androidInfo?.id : iosInfo?.identifierForVendor,
    //   deviceModel: Platform.isAndroid
    //       ? ("${androidInfo?.model} ${androidInfo?.device}").toUpperCase()
    //       : iosInfo?.model,
    // );
  }
}

class FileInit {
  String dirKey;
  String name;
  String value;

  FileInit({
    required this.dirKey,
    required this.name,
    required this.value,
  });
}

class DeviceInfo {
  String? imei;
  String? deviceId;
  String? deviceModel;

  DeviceInfo({
    this.imei,
    this.deviceId,
    this.deviceModel,
  });
}
