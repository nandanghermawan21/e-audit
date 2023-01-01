import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final String title;
  final String url;

  const Presenter({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<StatefulWidget> createState() {
    return View();
  }
}

abstract class PresenterState extends State<Presenter> {}
