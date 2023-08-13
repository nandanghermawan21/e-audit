import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_file_model.dart';
import 'package:eaudit/model/komentar_odel.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return CircularLoaderComponent(
      controller: loadingController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: System.data.color!.primaryColor,
          centerTitle: true,
          title: Text(
            "Tindak Lanjut Audit",
            style: System.data.textStyles!.boldTitleLightLabel,
          ),
        ),
        body: body(),
        bottomNavigationBar: Container(
          height: 50,
          margin: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              loadingController.stopLoading(
                message: "Data Berhasil Tersimpan",
                isError: false,
                duration: const Duration(seconds: 3),
                onCloseCallBack: () {
                  widget.onSubmitSuccess!();
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                System.data.color!.primaryColor,
              ),
            ),
            child: Text(
              "Simpan",
              style: System.data.textStyles!.boldTitleLightLabel,
            ),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "REVIU TIndak lanjUT",
              style: System.data.textStyles!.boldTitleLabel,
            ),
            const SizedBox(
              height: 10,
            ),
            detail(
              label: "Tindak Lanjut",
              value: "Test",
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  width: 100,
                  child: Text(
                    "Lampiran",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      AuditFileModel.dummy().length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            widget.onTapFile?.call(
                                AuditFileModel.dummy()[index].name,
                                AuditFileModel.dummy()[index].url ?? "");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              AuditFileModel.dummy()[index].name ?? "",
                              style:
                                  System.data.textStyles!.basicLabel.copyWith(
                                color: System.data.color!.primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  width: 100,
                  child: Text(
                    "Komentar",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children:
                        List.generate(KomentarModel.dummy().length, (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  KomentarModel.dummy()[index].name ?? "",
                                  style: System.data.textStyles!.boldTitleLabel,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  KomentarModel.dummy()[index].tanggal == null
                                      ? "-"
                                      : DateFormat("dd MMMM yyyy").format(
                                          (KomentarModel.dummy()[index]
                                              .tanggal!),
                                        ),
                                  style: System.data.textStyles!.basicLabel,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              KomentarModel.dummy()[index].komentar ?? "",
                              style: System.data.textStyles!.basicLabel,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                onChanged: (val) {
                  // data?.catatan = val;
                  // listController.commit();
                },
                maxLines: 5,
                decoration: InputDecoration.collapsed(
                  hintText: "Catatan",
                  hintStyle: System.data.textStyles!.basicLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detail({
    String? label,
    String? value,
    Color? valueColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.transparent,
                width: 100,
                child: Text(
                  label ?? "",
                  style: System.data.textStyles!.basicLabel,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  value ?? "",
                  style: System.data.textStyles!.basicLabel.copyWith(
                    color: valueColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
