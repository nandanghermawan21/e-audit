import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final String type;

  const Presenter({
    Key? key,
    this.view,
    required this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? View();
  }
}

abstract class PresenterState extends State<Presenter> {}
