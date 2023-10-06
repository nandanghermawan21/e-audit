import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_pka_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'presenter.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: System.data.color!.primaryColor,
        centerTitle: true,
        title: Text(
          "Program Kerja Audit",
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
    return Container(
      color: Colors.transparent,
      child: ListDataComponent<AuditPKAModel>(
        controller: listController,
        enableGetMore: false,
        enableDrag: false,
        dataSource: (skip, key) {
          return AuditPKAModel.get(
                  token: System.data.global.token, assignId: widget.auditPA?.id)
              .then((value) {
            return [value];
          });
        },
        itemBuilder: (data, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  description(data),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Daftar Anggota Tim",
                    style: System.data.textStyles!.boldTitleLabel,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  tableAnggota(data),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Daftar Program Audit",
                        style: System.data.textStyles!.boldTitleLabel,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onTapReviu!(widget.auditPA);
                          },
                          child: Text(
                            "Reviu PKA",
                            style: System.data.textStyles!.boldTitleLabel,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  programKerja(data),
                ],
              ),
            ),
          );
        },
        loaderWidget: SkeletonAnimation(
          shimmerColor: Colors.grey.shade300,
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget description(AuditPKAModel? data) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: 100,
              child: Text(
                "Nama kegiatan",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.namaKegiatan ?? "",
                style: System.data.textStyles!.basicLabel,
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
                "Auditee",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data?.auditee ?? "",
              style: System.data.textStyles!.basicLabel,
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
                "Tipe Audit",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data?.tipeAudit ?? "",
              style: System.data.textStyles!.basicLabel,
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
                "Tanggal Audit",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data?.tanggalAudit == null
                  ? "-"
                  : DateFormat("dd MMMM yyyy").format(
                      (data!.tanggalAudit!),
                    ),
              style: System.data.textStyles!.basicLabel,
            ),
          ],
        )
      ],
    );
  }

  Widget tableAnggota(AuditPKAModel? data) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.grey.shade200,
              child: Text(
                "No",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.grey.shade200,
              child: Text(
                "Nama Auditor",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.grey.shade200,
              child: Text(
                "Nama Auditee",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.grey.shade200,
              child: Text(
                "Posisi",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
          ],
        ),
        ...List.generate(
          data?.anggota?.length ?? 0,
          (index) {
            return TableRow(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${index + 1}",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${data?.anggota?[index].namaAuditor}",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${data?.anggota?[index].namaAuditee}",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "${data?.anggota?[index].posisi}",
                    style: System.data.textStyles!.basicLabel,
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }

  Widget programKerja(AuditPKAModel? data) {
    return Column(
      children: List.generate(
        data?.programAudit?.length ?? 0,
        (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Judul Program Nama Audit",
                              style: System.data.textStyles!.basicLabel,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              data?.programAudit?[index].judul ?? "",
                              style:
                                  System.data.textStyles!.basicLabel.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Status",
                              style: System.data.textStyles!.basicLabel,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              data?.programAudit?[index].status ?? "",
                              style:
                                  System.data.textStyles!.basicLabel.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IntrinsicWidth(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.onTapKKA?.call(
                                  widget.auditPA,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: System.data.color!.primaryColor
                                      .withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "KKA",
                                        style:
                                            System.data.textStyles!.basicLabel,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "2",
                                        style:
                                            System.data.textStyles!.basicLabel,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Temuan",
                                    style: System.data.textStyles!.basicLabel,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "0",
                                    style: System.data.textStyles!.basicLabel,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rekomendasi",
                                    style: System.data.textStyles!.basicLabel,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "0",
                                    style: System.data.textStyles!.basicLabel,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
