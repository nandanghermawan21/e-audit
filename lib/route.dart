import 'package:eaudit/util/enum.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:eaudit/component/d_chart_example.dart' as example;
import 'package:eaudit/module/splashScreen/main.dart' as splashscreen;
import 'package:eaudit/module/login/main.dart' as login;
import 'package:eaudit/module/home/main.dart' as home;
import 'package:eaudit/module/webView/main.dart' as webview;
import 'package:eaudit/module/manualBook/main.dart' as manualbook;
import 'package:eaudit/module/pdfViewer/main.dart' as pdfviewwer;
import 'package:eaudit/module/report/main.dart' as report;
import 'package:eaudit/module/reviewTask/main.dart' as reviewtask;
import 'package:eaudit/module/dashboard/main.dart' as dashboard;
import 'package:eaudit/module/reviu/main.dart' as reviu;
import 'package:eaudit/module/auditPA/main.dart' as audit_pa;
import 'package:eaudit/module/auditPKA/main.dart' as audit_pka;
import 'package:eaudit/module/auditPKAReviu/main.dart' as audit_pka_reviu;
import 'package:eaudit/module/auditKKA/main.dart' as audit_kka;
import 'package:eaudit/module/auditKKAReviu/main.dart' as audit_kka_reviu;

String initialRouteName = RouteName.splashScreen;

class RouteName {
  static const String example = "example";
  static const String splashScreen = "splashScreen";
  static const String login = "login";
  static const String home = "home";
  static const String webview = "webview";
  static const String manualBook = "manualBook";
  static const String pdfViewwer = "pdfviewer";
  static const String report = "report";
  static const String reviewtask = "reviewtask";
  static const String dashboard = "dashboard";
  static const String reviu = "reviu";
  static const String auditPA = "auditPA";
  static const String auditPKA = "auditPKA";
  static const String auditPKAReviu = "auditPKAReviu";
  static const String auditKKA = "auditKKA";
  static const String reviuKKAReviu = "reviuKKAReviu";
}

enum ParamName {
  title,
  url,
  centerTitle,
  message,
  tipeReviu,
  kka,
}

Map<String, WidgetBuilder> route = {
  RouteName.example: (BuildContext context) {
    return example.Home();
  },
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
      onTapUrl: (title, url, message) {
        Navigator.of(context).pushNamed(
          RouteName.webview,
          arguments: {
            ParamName.title: title,
            ParamName.url: url,
            ParamName.message: message,
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
      onTapDashboard: () {
        Navigator.of(context).pushNamed(RouteName.dashboard);
      },
      onTapLogout: () {
        System.data.session!.setString(SessionKey.user, "");
        System.data.global.user = null;
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.login, (r) => r.settings.name == "");
      },
      onTapReviu: () {
        Navigator.of(context).pushNamed(RouteName.reviu);
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
      message: arg[ParamName.message],
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
  },
  RouteName.dashboard: (BuildContext context) {
    return dashboard.Presenter(
      key: GlobalKey(),
    );
  },
  RouteName.reviu: (BuildContext context) {
    return reviu.Presenter(
      onTapReviuPKA: () {
        Navigator.of(context).pushNamed(
          RouteName.auditPA,
          arguments: {
            ParamName.tipeReviu: "PKA",
          },
        );
      },
      onTapReviuKKA: () {
        Navigator.of(context).pushNamed(
          RouteName.auditPA,
          arguments: {
            ParamName.tipeReviu: "KKA",
          },
        );
      },
      onTapReviuKKPT: () {
        Navigator.of(context).pushNamed(
          RouteName.auditPA,
          arguments: {
            ParamName.tipeReviu: "KKPT",
          },
        );
      },
      onTapReviuTindakLanjut: () {
        Navigator.of(context).pushNamed(
          RouteName.auditPA,
          arguments: {
            ParamName.tipeReviu: "TL",
          },
        );
      },
    );
  },
  RouteName.auditPA: (BuildContext context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>? ??
            {};
    return audit_pa.Presenter(
      type: arg[ParamName.tipeReviu],
      onTapItem: (data) {
        switch (data?.status) {
          case "PKA":
            Navigator.of(context).pushNamed(
              RouteName.auditPKA,
            );
            break;

          case "KKA":
            Navigator.of(context).pushNamed(
              RouteName.auditKKA,
            );
            break;

          default:
        }
      },
    );
  },
  RouteName.auditPKA: (BuildContext context) {
    return audit_pka.Presenter(
      onTapReviu: (data) {
        Navigator.of(context).pushNamed(
          RouteName.auditPKAReviu,
        );
      },
    );
  },
  RouteName.auditPKAReviu: (BuildContext context) {
    return audit_pka_reviu.Presenter(
      onSubmitSuccess: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.reviu, (r) => r.settings.name == "");
      },
    );
  },
  RouteName.auditKKA: (BuildContext context) {
    return audit_kka.Presenter(
      onSelectAction: (kka) {
        Navigator.of(context).pushNamed(
          RouteName.reviuKKAReviu,
          arguments: {
            ParamName.kka: kka,
          },
        );
      },
    );
  },
  RouteName.reviuKKAReviu: (BuildContext context) {
    Map<dynamic, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>? ??
            {};
    return audit_kka_reviu.Presenter(
      kka: arg[ParamName.kka],
      onSubmitSuccess: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.auditKKA, (r) => r.settings.name == RouteName.reviu);
      },
    );
  },
};
