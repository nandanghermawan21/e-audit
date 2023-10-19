import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/decoration_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_pka_model.dart';
import 'package:eaudit/model/komentar_model.dart';
import 'package:eaudit/model/program_audit_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
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
              submit();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                System.data.color!.primaryColor,
              ),
            ),
            child: Text(
              "Simpan Semua",
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
      child: ListDataComponent<ProgramAuditModel>(
        controller: listController,
        enableDrag: false,
        enableGetMore: false,
        canRefresh: false,
        dataSource: (skip, key) {
          return AuditPKAModel.get(
                  token: System.data.global.token, assignId: widget.auditPA?.id)
              .then((value) {
            return value.programAudit ?? [];
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
                Html(
                  data: data?.langkahKerja ?? "",
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Waktu (Hari)",
                          style: System.data.textStyles!.boldTitleLabel,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${data?.jumlahHari.toString() ?? ""} Hari",
                          style: System.data.textStyles!.basicLabel,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Status",
                          style: System.data.textStyles!.boldTitleLabel,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          data?.status ?? "",
                          style: System.data.textStyles!.basicLabel,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("Komentar",
                    style: System.data.textStyles!.boldTitleLabel.copyWith(
                      fontSize: 16,
                    )),
                const SizedBox(
                  height: 10,
                ),
                komentar(data?.komentar),
                SizedBox(
                  height: data?.isFinishedReviu == false ? 20 : 10,
                ),
                data?.isFinishedReviu == false
                    ? Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Aksi",
                              style: System.data.textStyles!.boldTitleLabel,
                            ),
                          ),
                          Row(
                            children: [
                              Radio(
                                value: "2",
                                groupValue: data?.approve,
                                onChanged: (val) {
                                  data?.approve = val.toString();
                                  listController.commit();
                                },
                              ),
                              Text(
                                "Setujui",
                                style: System.data.textStyles!.basicLabel,
                              ),
                              Radio(
                                value: "3",
                                groupValue: data?.approve,
                                onChanged: (val) {
                                  data?.approve = val.toString();
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
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status",
                            style: System.data.textStyles!.boldTitleLabel,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data?.approve == "2"
                                ? "Disetujui"
                                : data?.approve == "3"
                                    ? "Ditolak"
                                    : "",
                            style: System.data.textStyles!.boldTitleLabel,
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                data?.isFinishedReviu == false
                    ? Text(
                        "Catatan",
                        style: System.data.textStyles!.boldTitleLabel,
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                //buat textbox dengan border
                data?.isFinishedReviu == false
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: data?.catatan,
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
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                data?.isFinishedReviu == false
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            submitSingle(data!);
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
                      )
                    : const SizedBox()
              ],
            ),
          );
        },
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
}
