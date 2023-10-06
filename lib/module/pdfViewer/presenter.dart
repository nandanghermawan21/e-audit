import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'main.dart' as main;

class Presenter extends StatefulWidget {
  final String title;
  final String url;
  final bool centerTile;

  const Presenter({
    Key? key,
    required this.title,
    required this.url,
    required this.centerTile,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return main.View();
  }
}

abstract class PresenterState extends State<Presenter> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pdfViewerKey.currentState?.openBookmarkView();
  }
}
