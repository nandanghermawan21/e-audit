import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'main.dart' as main;
import 'view_model.dart';

class Presenter extends StatefulWidget {
  final State<Presenter>? view;
  final ValueChanged<int>? onTapReviuPKA;
  final ValueChanged<int>? onTapReviuKKA;
  final ValueChanged<int>? onTapReviuKKPT;
  final ValueChanged<int>? onTapReviuTindakLanjut;

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
    return view ?? main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = ViewModel();

  @override
  void dispose() {
    System.data.getNotifikasiData(System.data.global.token ?? "");
    super.dispose();
  }
}
