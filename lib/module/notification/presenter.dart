import 'package:eaudit/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final ValueChanged<NotificationModel?>? onTapNotification;

  const Presenter({
    Key? key,
    this.view,
    this.onTapNotification,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? View();
  }
}

abstract class PresenterState extends State<Presenter> {}
