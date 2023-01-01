import 'package:eaudit/util/system.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'presenter.dart';
import 'package:flutter/material.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: widget.centerTile,
        backgroundColor: System.data.color!.primaryColor,
        title: Text(
          widget.title,
          style: System.data.textStyles!.boldTitleLightLabel,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              launchUrl(
                Uri.parse(
                  widget.url,
                ),
                mode: LaunchMode.externalApplication,
              );
            },
            child: Container(
              width: 50,
              color: Colors.transparent,
              child: const Icon(
                FontAwesomeIcons.download,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.green,
        width: double.infinity,
        height: double.infinity,
        child: SfPdfViewer.network(
          widget.url,
          key: pdfViewerKey,
        ),
      ),
    );
  }
}
