import 'package:eaudit/util/system.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'presenter.dart';
import 'package:flutter/material.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: System.data.color!.primaryColor,
        centerTitle: true,
        title: Text(
          widget.title,
          style: System.data.textStyles!.boldTitleLightLabel,
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
