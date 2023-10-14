import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_file_model.dart';
import 'package:eaudit/model/komentar_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:eaudit/component/decoration_component.dart';
import 'package:flutter_html/flutter_html.dart';

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
            "Tindak Lanjut Audit",
            style: System.data.textStyles!.boldTitleLightLabel,
          ),
        ),
        body: body(),
        bottomNavigationBar: Container(
          height: 50,
          margin: const EdgeInsets.all(20),
          child: Row(
            children: List.generate(
              widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi?.first
                      ?.listItem?.first?.action?.length ??
                  0,
              (index) {
                return Expanded(
                  child: DecorationComponent.buttonAction(
                      loadingController: loadingController,
                      action: widget
                          .auditTLReviu
                          ?.listAuditTL
                          ?.first
                          ?.listRekomendasi
                          ?.first
                          ?.listItem
                          ?.first
                          ?.action?[index],
                      data: widget.auditTLReviu,
                      beforeAction: () {
                        if (catatanController.text == "") {
                          loadingController.stopLoading(
                            message: "Catatan tidak boleh kosong",
                            isError: true,
                          );
                          return false;
                        } else {
                          return true;
                        }
                      },
                      onCofirmAction: (data) {
                        postReviu(widget
                            .auditTLReviu
                            ?.listAuditTL
                            ?.first
                            ?.listRekomendasi
                            ?.first
                            ?.listItem
                            ?.first
                            ?.action?[index]
                            ?.value);
                      }),
                );
              },
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
              "Rekomendasi Tindak Lanjut",
              style: System.data.textStyles!.boldTitleLabel,
            ),
            const SizedBox(
              height: 10,
            ),
            DecorationComponent.item(
              title: "No Temuan",
              value: widget.auditTLReviu?.listAuditTL?.first?.noTemuan,
            ),
            DecorationComponent.item(
              title: "Judul Temuan",
              value: widget.auditTLReviu?.listAuditTL?.first?.judulTemuan,
            ),
            DecorationComponent.item(
                title: "Rekomendasi",
                valueWidget: Html(
                  data: widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi
                      ?.first?.deskripsi,
                  shrinkWrap: true,
                  style: {
                    "body": Style(
                      fontSize: const FontSize(17),
                      fontFamily: System.data.font!.primary,
                    ),
                    "*": Style(
                      fontSize: const FontSize(17),
                      fontFamily: System.data.font!.primary,
                    ),
                  },
                )),
            DecorationComponent.item(
              title: "Status Rekomendasi",
              value: widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi
                  ?.first?.statusRekomendasi,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Reviu Tindak Lanjut",
              style: System.data.textStyles!.boldTitleLabel,
            ),
            const SizedBox(
              height: 10,
            ),
            DecorationComponent.item(
              title: "Tindak Lanjut",
              value: "Test",
            ),
            DecorationComponent.item(
              title: "Lampiran",
              valueWidget: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi
                            ?.first?.listItem?.first?.lampiran?.length ??
                        0,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          widget.onTapFile?.call(
                              widget
                                  .auditTLReviu
                                  ?.listAuditTL
                                  ?.first
                                  ?.listRekomendasi
                                  ?.first
                                  ?.listItem
                                  ?.first
                                  ?.lampiran?[index]
                                  ?.name,
                              widget
                                      .auditTLReviu
                                      ?.listAuditTL
                                      ?.first
                                      ?.listRekomendasi
                                      ?.first
                                      ?.listItem
                                      ?.first
                                      ?.lampiran?[index]
                                      ?.url ??
                                  "");
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            AuditFileModel.dummy()[index].name ?? "",
                            style: System.data.textStyles!.basicLabel.copyWith(
                              color: System.data.color!.primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Komentar",
              style: System.data.textStyles!.boldTitleLabel,
            ),
            const SizedBox(
              height: 10,
            ),
            komentar(widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi
                ?.first?.listItem?.first?.komentar),
            catatan(),
          ],
        ),
      ),
    );
  }

  Widget komentar(List<KomentarModel?>? data) {
    return SizedBox(
      child: Column(
        children: List.generate(data?.length ?? 0, (index) {
          return DecorationComponent.itemKomentar((data![index]!));
        }),
      ),
    );
  }

  Widget catatan() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: catatanController,
        maxLines: 5,
        decoration: InputDecoration.collapsed(
          hintText: "Catatan",
          hintStyle: System.data.textStyles!.basicLabel,
        ),
      ),
    );
  }
}
