import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: System.data.color!.primaryColor,
        centerTitle: true,
        title: Text(
          "Daftar Reviu",
          style: System.data.textStyles!.boldTitleLightLabel,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 50,
            color: Colors.transparent,
          )
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            item(
              label: "Reviu PKA",
              value: 3,
              onTap: widget.onTapReviuPKA,
            ),
            item(
              label: "Reviu KKA",
              value: 2,
              onTap: widget.onTapReviuKKA,
            ),
            item(
              label: "Reviu KKPT",
              value: 2,
              onTap: widget.onTapReviuKKPT,
            ),
            item(
              label: "Reviu Tindak Lanjut",
              value: 2,
              onTap: widget.onTapReviuTindakLanjut,
            ),
          ],
        ),
      ),
    );
  }

  Widget item({
    VoidCallback? onTap,
    String? label,
    int? value,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: System.data.color!.background,
          border: Border.all(
            color: System.data.color!.darkBackgroundBorder,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label ?? "",
                style: System.data.textStyles!.boldTitleLabel,
              ),
            ),
            CircleAvatar(
              backgroundColor: System.data.color!.primaryColor,
              maxRadius: 15,
              child: Text(
                value?.toString() ?? "",
                style: System.data.textStyles!.basicLightLabel,
              ),
            )
          ],
        ),
      ),
    );
  }
}
