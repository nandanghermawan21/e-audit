import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_rekomendasi_status_model.dart';
import 'package:eaudit/model/audit_tl_model.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
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
            "Tindak Lanjut Audit",
            style: System.data.textStyles!.boldTitleLightLabel,
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 50,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  listDataComponentController.refresh();
                },
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [
            searchBox(),
            lagend(),
            ListDataComponent<AuditTLModel>(
              controller: super.listDataComponentController,
              enableDrag: false,
              enableGetMore: false,
              autoSearch: false,
              dataSource: (skip, key) {
                return AuditTLModel.get(
                  assignId: widget.auditTLReviu?.id,
                  token: System.data.global.token,
                  status: selectedStatus,
                  searchKey: seacchController.text,
                  type: widget.type,
                );
              },
              listViewMode: ListDataComponentMode.column,
              itemBuilder: (data, index) {
                return rekomendasiItem(data);
              },
            )
            // ...List.generate(
            //   widget.auditTLReviu?.listAuditTL?.length ?? 0,
            //   (index) {
            //     return rekomendasiItem(
            //         widget.auditTLReviu?.listAuditTL![index]);
            //   },
            // )
          ],
        ),
      ),
    );
  }

  Widget rekomendasiItem(AuditTLModel? data) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Judul Temuan",
            style: System.data.textStyles!.boldTitleLabel,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Html(
                data: data?.judulTemuan ?? "",
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
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Rekomendasi",
            style: System.data.textStyles!.boldTitleLabel,
          ),
          (data?.listRekomendasi?.length ?? 0) == 0
              ? Text("Tidak ada rekomendasi",
                  style: System.data.textStyles!.basicLabel)
              : Column(
                  children: List.generate(
                    data?.listRekomendasi?.length ?? 0,
                    (index2) {
                      return Container(
                        padding: const EdgeInsets.only(bottom: 10, top: 40),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      System.data.color!.primaryColor,
                                  child: Text(
                                    "${index2 + 1}",
                                    style: System
                                        .data.textStyles!.boldTitleLightLabel,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: data
                                                        ?.listRekomendasi?[
                                                            index2]
                                                        ?.statusRekomendasiColor ??
                                                    Colors.green,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5))),
                                            child: Text(
                                              data?.listRekomendasi?[index2]
                                                      ?.statusRekomendasi ??
                                                  "",
                                              style: System.data.textStyles!
                                                  .boldTitleLightLabel,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Text(
                                              "Sisa ${data?.listRekomendasi?[index2]?.sisaHariTindakLanjut ?? ""} Hari",
                                              style: System.data.textStyles!
                                                  .boldTitleLabel,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Html(
                                        data: data?.listRekomendasi?[index2]
                                            ?.deskripsi,
                                        shrinkWrap: true,
                                        style: {
                                          "body": Style(
                                            fontSize: const FontSize(17),
                                            fontFamily:
                                                System.data.font!.primary,
                                          ),
                                          "*": Style(
                                            fontSize: const FontSize(17),
                                            fontFamily:
                                                System.data.font!.primary,
                                          ),
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    widget.onSelectAction(
                                      AuditTLReviuModel(
                                        obyekAudit:
                                            widget.auditTLReviu?.obyekAudit,
                                        nomorLha: widget.auditTLReviu?.nomorLha,
                                        listAuditTL: [
                                          AuditTLModel(
                                              id: data?.id,
                                              noTemuan: data?.noTemuan,
                                              judulTemuan: data?.judulTemuan,
                                              uraianTemuan: data?.uraianTemuan,
                                              rekomendasi: data?.rekomendasi,
                                              listRekomendasi: [
                                                data?.listRekomendasi?[index2],
                                              ])
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(left: 5),
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: data?.listRekomendasi?[index2]
                                          ?.statusTindakLanjutColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Tindak Lanjut',
                                          // "${data.listRekomendasi?[index2]?.statusTindakLanjut ?? ""}}",
                                          style: System.data.textStyles!
                                              .boldTitleLightLabel,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Container(
              height: double.infinity,
              color: Colors.transparent,
              child: FutureBuilder<List<AuditRekomendasiStatusModel>>(
                future: AuditRekomendasiStatusModel.get(
                  token: System.data.global.token,
                ),
                builder: (c, s) {
                  if (s.connectionState != ConnectionState.done) {
                    return const SizedBox(
                      width: 100,
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                    );
                  }
                  return StreamBuilder<String?>(
                    initialData: selectedStatus,
                    stream: statusController.stream,
                    builder: (sccs, ss) {
                      return DropdownButton<String>(
                        isExpanded: true,
                        value: selectedStatus,
                        hint: Text(
                          "status",
                          style: System.data.textStyles!.basicLabel.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        items: List.generate(
                          (s.data ?? []).length,
                          (index) {
                            return DropdownMenuItem<String>(
                              value: s.data![index].id,
                              child: Text(s.data![index].name!,
                                  style: System.data.textStyles!.basicLabel),
                            );
                          },
                        ),
                        onChanged: (val) {
                          selectedStatus = val ?? "";
                          statusController.add(val);
                          listDataComponentController.refresh();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              height: 32,
              color: Colors.transparent,
              child: TextField(
                controller: seacchController,
                decoration: const InputDecoration(
                  hintText: "Cari",
                  contentPadding: EdgeInsets.only(
                    left: 1,
                    right: 1,
                    top: 5,
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (val) {
                  listDataComponentController.refresh();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget lagend() {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey.shade200,
        width: double.infinity,
        child: FutureBuilder<List<AuditRekomendasiStatusModel>>(
          future: AuditRekomendasiStatusModel.get(
            token: System.data.global.token,
          ),
          builder: (c, s) {
            if (s.connectionState != ConnectionState.done) {
              return const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                (s.data ?? []).length,
                (index) {
                  return IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            color: s.data![index].color,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            s.data![index].name!,
                            style: System.data.textStyles!.basicLabel,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
