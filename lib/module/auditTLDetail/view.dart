import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/audit_rekomendasi_model.dart';
import 'package:eaudit/model/audit_tl_model.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/model/komentar_odel.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'view_model.dart';
import 'presenter.dart';
import 'package:eaudit/component/decoration_component.dart';

class View extends PresenterState {
  @override
  Widget build(BuildContext context) {
    return CircularLoaderComponent(
      controller: loadingController,
      child: ChangeNotifierProvider.value(
        value: model,
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
              value: widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi
                  ?.first?.deskripsi,
            ),
            DecorationComponent.item(
              title: "Status Rekomendasi",
              value: widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi
                  ?.first?.status,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 100,
                ),
                Consumer<ViewModel>(builder: (c, d, w) {
                  return Expanded(
                    child: Row(
                      children: [
                        buttonSetStatusRecomendation(
                            data: model.auditTLReviuModel?.listAuditTL?.first
                                ?.listRekomendasi?.first,
                            status: "Selesai"),
                        buttonSetStatusRecomendation(
                            data: model.auditTLReviuModel?.listAuditTL?.first
                                ?.listRekomendasi?.first,
                            status: "Dalam Proses"),
                        buttonSetStatusRecomendation(
                            data: model.auditTLReviuModel?.listAuditTL?.first
                                ?.listRekomendasi?.first,
                            status: "TDTL"),
                      ],
                    ),
                  );
                })
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Komentar",
              style: System.data.textStyles!.boldTitleLabel,
            ),
            const SizedBox(
              height: 10,
            ),
            komentar(widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi
                ?.first?.komentar),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Daftar Tindak Lanjut",
              style: System.data.textStyles!.boldTitleLabel,
            ),
            const SizedBox(
              height: 10,
            ),
            ...List.generate(
              widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi?.first
                      ?.listItem?.length ??
                  0,
              (index) {
                return GestureDetector(
                  onTap: () {
                    widget.onSelectAction?.call(AuditTLReviuModel(
                      obyekAudit: widget.auditTLReviu?.obyekAudit,
                      nomorLha: widget.auditTLReviu?.nomorLha,
                      listAuditTL: [
                        AuditTLModel(
                            noTemuan: widget
                                .auditTLReviu?.listAuditTL?.first?.noTemuan,
                            judulTemuan: widget
                                .auditTLReviu?.listAuditTL?.first?.judulTemuan,
                            uraianTemuan: widget
                                .auditTLReviu?.listAuditTL?.first?.uraianTemuan,
                            rekomendasi: widget
                                .auditTLReviu?.listAuditTL?.first?.rekomendasi,
                            listRekomendasi: [
                              AuditRekomendasiModel(
                                  deskripsi: widget
                                      .auditTLReviu
                                      ?.listAuditTL
                                      ?.first
                                      ?.listRekomendasi
                                      ?.first
                                      ?.deskripsi,
                                  sisaHariTindakLanjut: widget
                                      .auditTLReviu
                                      ?.listAuditTL
                                      ?.first
                                      ?.listRekomendasi
                                      ?.first
                                      ?.sisaHariTindakLanjut,
                                  status: widget.auditTLReviu?.listAuditTL
                                      ?.first?.listRekomendasi?.first?.status,
                                  color: widget.auditTLReviu?.listAuditTL?.first
                                      ?.listRekomendasi?.first?.color,
                                  listItem: [
                                    widget
                                        .auditTLReviu
                                        ?.listAuditTL
                                        ?.first
                                        ?.listRekomendasi
                                        ?.first
                                        ?.listItem?[index]
                                  ])
                            ]),
                      ],
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tindak Lanjut",
                                    style:
                                        System.data.textStyles!.boldTitleLabel,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget
                                            .auditTLReviu
                                            ?.listAuditTL
                                            ?.first
                                            ?.listRekomendasi
                                            ?.first
                                            ?.listItem?[index]
                                            ?.tindakLanjut ??
                                        "",
                                    style: System.data.textStyles!.basicLabel,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tanggal",
                                    style:
                                        System.data.textStyles!.boldTitleLabel,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget
                                                .auditTLReviu
                                                ?.listAuditTL
                                                ?.first
                                                ?.listRekomendasi
                                                ?.first
                                                ?.listItem?[index]
                                                ?.tanggal !=
                                            null
                                        ? DateFormat("dd MMMM yyyy").format(
                                            widget
                                                .auditTLReviu!
                                                .listAuditTL!
                                                .first!
                                                .listRekomendasi!
                                                .first!
                                                .listItem![index]!
                                                .tanggal!)
                                        : "",
                                    style: System.data.textStyles!.basicLabel,
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
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status TL",
                                    style:
                                        System.data.textStyles!.boldTitleLabel,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget
                                            .auditTLReviu
                                            ?.listAuditTL
                                            ?.first
                                            ?.listRekomendasi
                                            ?.first
                                            ?.listItem?[index]
                                            ?.status ??
                                        "",
                                    style: System.data.textStyles!.basicLabel,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.transparent,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonSetStatusRecomendation({
    AuditRekomendasiModel? data,
    String? status,
  }) {
    return GestureDetector(
      onTap: () {
        loadingController.stopLoading(
          icon: const Icon(
            Icons.check_circle_outline,
            size: 0,
          ),
          messageWidget: SizedBox(
            child: Column(
              children: [
                Text(
                  "Ubah atatus rekomendasi menjasi '$status'",
                  style: System.data.textStyles!.basicLabel,
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          loadingController.forceStop();
                          data?.statusRekomensai = status;
                          model.commit();
                        },
                        child: Text(
                          "Ya",
                          style: System.data.textStyles!.boldTitleLightLabel,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          loadingController.forceStop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.red.shade300,
                          ),
                        ),
                        child: Text(
                          "Tidak",
                          style: System.data.textStyles!.boldTitleLightLabel,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: data?.statusRekomensai == status
              ? System.data.color!.primaryColor
              : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          border: Border.all(color: Colors.grey.shade500),
        ),
        child: Text(
          status ?? "",
          style: System.data.textStyles!.basicLabel.copyWith(
            color: data?.statusRekomensai == status
                ? Colors.white
                : Colors.grey.shade500,
          ),
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
    );
  }
}
