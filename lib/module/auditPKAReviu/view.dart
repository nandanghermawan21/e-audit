import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_pka_reviu_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return CircularLoaderComponent(
      controller: loadingController,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: System.data.color!.primaryColor,
          centerTitle: true,
          title: Text(
            "Reviu Program Kerja Audit",
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
      color: Colors.transparent,
      child: ListDataComponent<AuditPKAReviuModel>(
        controller: listController,
        enableDrag: false,
        enableGetMore: false,
        dataSource: (skip, key) {
          return Future.value().then((value) {
            return AuditPKAReviuModel.dummys();
          });
        },
        itemBuilder: (data, index) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.judul ?? "",
                  style: System.data.textStyles!.boldTitleLabel,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Langkah Kerja",
                  style: System.data.textStyles!.boldTitleLabel,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data?.langkahKerja ?? "",
                  style: System.data.textStyles!.basicLabel,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Waktu (Hari)",
                  style: System.data.textStyles!.boldTitleLabel,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${data?.waktuhari.toString() ?? ""} Hari",
                  style: System.data.textStyles!.basicLabel,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Status",
                        style: System.data.textStyles!.boldTitleLabel,
                      ),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: "approve",
                          groupValue: data?.status,
                          onChanged: (val) {
                            data?.status = val.toString();
                            listController.commit();
                          },
                        ),
                        Text(
                          "Approve",
                          style: System.data.textStyles!.basicLabel,
                        ),
                        Radio(
                          value: "Tolak",
                          groupValue: data?.status,
                          onChanged: (val) {
                            data?.status = val.toString();
                            listController.commit();
                          },
                        ),
                        Text(
                          "Tolak",
                          style: System.data.textStyles!.basicLabel,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Catatan",
                  style: System.data.textStyles!.boldTitleLabel,
                ),
                const SizedBox(
                  height: 10,
                ),
                //buat textbox dengan border
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    onChanged: (val) {
                      data?.catatan = val;
                      listController.commit();
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
          );
        },
      ),
    );
  }
}
