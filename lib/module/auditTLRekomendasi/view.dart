import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_tl_model.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
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
          actions: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 50,
              color: Colors.transparent,
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
          children: List.generate(
            widget.auditTLReviu?.listAuditTL?.length ?? 0,
            (index) {
              return Container(
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
                      "Uraian Temuan",
                      style: System.data.textStyles!.boldTitleLabel,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Penerbitan Sertifikat Penjaminan Kontra Bank Garansi Melebihi Batas Service Level Agreement (SLA) yang Ditentukan pada Perjanjian Kerjasama",
                      style: System.data.textStyles!.basicLabel,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Rekomendasi",
                      style: System.data.textStyles!.boldTitleLabel,
                    ),
                    ...List.generate(
                      widget.auditTLReviu?.listAuditTL?[index]?.listRekomendasi
                              ?.length ??
                          0,
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
                                                  color: widget
                                                          .auditTLReviu
                                                          ?.listAuditTL?[index]
                                                          ?.listRekomendasi?[
                                                              index2]
                                                          ?.color ??
                                                      Colors.green,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5))),
                                              child: Text(
                                                widget
                                                        .auditTLReviu
                                                        ?.listAuditTL?[index]
                                                        ?.listRekomendasi?[
                                                            index2]
                                                        ?.status ??
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
                                                "Sisa ${widget.auditTLReviu?.listAuditTL?[index]?.listRekomendasi?[index2]?.sisaHariTindakLanjut ?? ""} Hari",
                                                style: System.data.textStyles!
                                                    .boldTitleLabel,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget
                                                  .auditTLReviu
                                                  ?.listAuditTL?[index]
                                                  ?.listRekomendasi?[index2]
                                                  ?.deskripsi ??
                                              "",
                                          style: System
                                              .data.textStyles?.basicLabel,
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
                                          nomorLha:
                                              widget.auditTLReviu?.nomorLha,
                                          listAuditTL: [
                                            AuditTLModel(
                                                uraianTemuan: widget
                                                    .auditTLReviu
                                                    ?.listAuditTL?[index]
                                                    ?.uraianTemuan,
                                                rekomendasi: widget
                                                    .auditTLReviu
                                                    ?.listAuditTL?[index]
                                                    ?.rekomendasi,
                                                listRekomendasi: [
                                                  widget
                                                          .auditTLReviu
                                                          ?.listAuditTL?[index]
                                                          ?.listRekomendasi?[
                                                      index2],
                                                ])
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      margin: const EdgeInsets.only(left: 5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: System
                                            .data.color!.primaryColorLight,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Tindak Lanjut",
                                        style: System.data.textStyles!
                                            .boldTitleLightLabel,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
