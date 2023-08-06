import 'package:flutter/material.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final VoidCallback? onTapReviuPKA;
  final VoidCallback? onTapReviuKKA;
  final VoidCallback? onTapReviuKKPT;
  final VoidCallback? onTapReviuTindakLanjut;

  const Presenter({
    Key? key,
    this.view,
    this.onTapReviuPKA,
    this.onTapReviuKKA,
    this.onTapReviuKKPT,
    this.onTapReviuTindakLanjut,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return view ?? View();
  }
}

abstract class PresenterState extends State<Presenter> {}
