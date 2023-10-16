import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/user_model.dart';
import 'package:eaudit/util/enum.dart';
import 'package:eaudit/util/error_handling_util.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final VoidCallback? onLoginSuccess;
  const Presenter({
    Key? key,
    required this.onLoginSuccess,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  CircularLoaderController loadingController = CircularLoaderController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController capchaController = TextEditingController();

  final userNameErrorState = StreamController<bool>();
  final passwordErrorState = StreamController<bool>();
  final capchaErrorState = StreamController<bool>();

  String? capcha = "";

// controller.sink.add("Data!");

  @override
  void initState() {
    super.initState();
    capcha = Random().nextInt(max(1000, 9999)).toString();
  }

  bool validate() {
    bool isValid = true;
    isValid = validateUsername() ?? isValid;
    isValid = validatePassword() ?? isValid;
    isValid = validateCapcha() ?? isValid;
    return isValid;
  }

  bool? validateUsername() {
    if (usernameController.text != "") {
      userNameErrorState.add(false);
      return null;
    } else {
      userNameErrorState.add(true);
      return false;
    }
  }

  bool? validatePassword() {
    if (passwordController.text != "") {
      passwordErrorState.add(false);
      return null;
    } else {
      passwordErrorState.add(true);
      return false;
    }
  }

  bool? validateCapcha() {
    if (capchaController.text == "") {
      capchaErrorState.add(true);
      loadingController.stopLoading(isError: true, message: "Harap isi capcha");
      return false;
    } else if (capchaController.text != "" && capchaController.text == capcha) {
      capchaErrorState.add(false);
      return null;
    } else {
      capchaErrorState.add(true);
      loadingController.stopLoading(
          isError: true, message: "Capcha tidak sesuai");
      return false;
    }
  }

  void login() {
    if (!validate()) return;
    loadingController.startLoading();
    UserModel.login(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
      token: System.data.global.token,
    ).then(
      (value) {
        System.data.session!
            .setString(SessionKey.user, json.encode(value.toJson()));
        System.data.global.user = value;
        widget.onLoginSuccess!();
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
