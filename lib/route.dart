import 'package:eaudit/util/enum.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:eaudit/module/splashScreen/main.dart' as splashscreen;
import 'package:eaudit/module/login/main.dart' as login;
import 'package:eaudit/module/home/main.dart' as home;
import 'package:eaudit/module/webView/main.dart' as webview;
import 'package:eaudit/module/manualBook/main.dart' as manualbook;
import 'package:eaudit/module/pdfViewer/main.dart' as pdfviewwer;
import 'package:eaudit/module/report/main.dart' as report;
import 'package:eaudit/module/reviewTask/main.dart' as reviewtask;

String initialRouteName = RouteName.splashScreen;

class RouteName {
  static const String splashScreen = "splashScreen";
  static const String login = "login";
  static const String home = "home";
  static const String webview = "webview";
  static const String manualBook = "manualBook";
  static const String pdfViewwer = "pdfviewer";
  static const String report = "report";
  static const String reviewtask = "reviewtask";
}

enum ParamName {
  title,
  url,
  centerTitle,
}

Map<String, WidgetBuilder> route = {
  RouteName.splashScreen: (BuildContext context) {
    return splashscreen.Presenter(
      onFinishSplashScreen: () {
        if (System.data.global.user == null) {
          Navigator.of(context).pushReplacementNamed(RouteName.login);
        } else {
          Navigator.of(context).pushReplacementNamed(RouteName.home);
        }
      },
    );
  },
  RouteName.login: (BuildContext context) {
    return login.Presenter(
      onLoginSuccess: () {
        Navigator.of(context).pushReplacementNamed(RouteName.home);
      },
    );
  },
  RouteName.home: (BuildContext context) {
    return home.Presenter(
      onTapUrl: (title, url) {
        Navigator.of(context).pushNamed(
          RouteName.webview,
          arguments: {
            ParamName.title: title,
            ParamName.url: url,
          },
        );
      },
      onTapManualBook: () {
        Navigator.of(context).pushNamed(RouteName.manualBook);
      },
      onTapReport: () {
        Navigator.of(context).pushNamed(RouteName.report);
      },
      onTapReviewTask: () {
        Navigator.of(context).pushNamed(RouteName.reviewtask);
      },
      onTapLogout: () {
        System.data.session!.setString(SessionKey.user, "");
        System.data.global.user = null;
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.login, (r) => r.settings.name == "");
      },
    );
  },
  RouteName.webview: (BuildContext context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>? ??
            {};
    return webview.Presenter(
      title: arg[ParamName.title],
      url: arg[ParamName.url],
    );
  },
  RouteName.manualBook: (BuildContext context) {
    return manualbook.Presenter(
      onTapItem: (title, url) {
        Navigator.of(context).pushNamed(RouteName.pdfViewwer, arguments: {
          ParamName.title: title,
          ParamName.url: url,
        });
      },
    );
  },
  RouteName.pdfViewwer: (BuildContext context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>? ??
            {};
    return pdfviewwer.Presenter(
      centerTile: arg[ParamName.centerTitle] ?? true,
      title: arg[ParamName.title] ?? "",
      url: arg[ParamName.url] ?? "",
    );
  },
  RouteName.report: (BuildContext context) {
    return report.Presenter(
      onTapDocument: (title, url) {
        Navigator.of(context).pushNamed(RouteName.pdfViewwer, arguments: {
          ParamName.centerTitle: false,
          ParamName.title: title,
          ParamName.url: url,
        });
      },
    );
  },
  RouteName.reviewtask: (BuildContext context) {
    return reviewtask.Presenter(
      key: GlobalKey(),
    );
  }
};
