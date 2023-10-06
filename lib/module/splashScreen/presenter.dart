import 'dart:async';
import 'dart:convert';

import 'package:eaudit/model/user_model.dart';
import 'package:eaudit/util/enum.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final VoidCallback onFinishSplashScreen;

  const Presenter({
    Key? key,
    required this.onFinishSplashScreen,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  @override
  void initState() {
    super.initState();
    startCheck();
  }

  void startCheck() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      String user = System.data.session!.getString(SessionKey.user) ?? "";
      if (user != "") {
        System.data.global.user = UserModel.fromJson(json.decode(user));
      }
      widget.onFinishSplashScreen();
    });
  }
}
