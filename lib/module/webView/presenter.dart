import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final String title;
  final String url;
  final String? message;

  const Presenter({
    Key? key,
    required this.title,
    required this.url,
    this.message,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return View();
  }
}

abstract class PresenterState extends State<Presenter> {
  CircularLoaderController loadingController = CircularLoaderController();

  @override
  void initState() {
    super.initState();
    if (widget.message != null && widget.message != "") {
      loadingController.stopLoading(
        icon: Icon(
          FontAwesomeIcons.infoCircle,
          size: 50,
          color: System.data.color!.warningColor,
        ),
        message: widget.message,
      );
    }
  }
}
