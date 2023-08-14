import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/model/action_model.dart';
import 'package:eaudit/model/audit_rekomendasi_model.dart';
import 'package:eaudit/model/audit_tl_model.dart';
import 'package:eaudit/model/audit_tl_reviu_model.dart';
import 'package:eaudit/model/komentar_odel.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'view_model.dart';
import 'presenter.dart';

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
            detail(
              label: "No Temuan",
              value: widget.auditTLReviu?.listAuditTL?.first?.noTemuan,
            ),
            detail(
              label: "Judul Temuan",
              value: widget.auditTLReviu?.listAuditTL?.first?.judulTemuan,
            ),
            detail(
              label: "Rekomendasi",
              value: widget.auditTLReviu?.listAuditTL?.first?.listRekomendasi
                  ?.first?.deskripsi,
            ),
            detail(
              label: "Status Rekomendasi",
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
              height: 10,
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
              height: 5,
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
                return Container(
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
                                  style: System.data.textStyles!.boldTitleLabel,
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
                                  style: System.data.textStyles!.boldTitleLabel,
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
                                      ? DateFormat("dd MMMM yyyy").format(widget
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
                                  style: System.data.textStyles!.boldTitleLabel,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: List.generate(ActionModel.dummy().length,
                              (indexAction) {
                            return buttonAction(
                              action: ActionModel.dummy()[indexAction],
                              data: AuditTLReviuModel(
                                obyekAudit: widget.auditTLReviu?.obyekAudit,
                                nomorLha: widget.auditTLReviu?.nomorLha,
                                listAuditTL: [
                                  AuditTLModel(
                                      noTemuan: widget.auditTLReviu?.listAuditTL
                                          ?.first?.noTemuan,
                                      judulTemuan: widget.auditTLReviu
                                          ?.listAuditTL?.first?.judulTemuan,
                                      uraianTemuan: widget.auditTLReviu
                                          ?.listAuditTL?.first?.uraianTemuan,
                                      rekomendasi: widget.auditTLReviu
                                          ?.listAuditTL?.first?.rekomendasi,
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
                                            status: widget
                                                .auditTLReviu
                                                ?.listAuditTL
                                                ?.first
                                                ?.listRekomendasi
                                                ?.first
                                                ?.status,
                                            color: widget
                                                .auditTLReviu
                                                ?.listAuditTL
                                                ?.first
                                                ?.listRekomendasi
                                                ?.first
                                                ?.color,
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
                              ),
                            );
                          }),
                        ),
                      )
                    ],
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

  Widget buttonAction({
    required ActionModel? action,
    required AuditTLReviuModel? data,
  }) {
    return GestureDetector(
      onTap: () {
        loadingController.stopLoading(
          icon: const Icon(
            FontAwesomeIcons.questionCircle,
            color: Colors.orange,
            size: 50,
          ),
          messageWidget: IntrinsicHeight(
            child: Column(
              children: [
                Text(
                  "Anda Yakin Untuk ${action?.description} Tindak lanjut Satuan Kerja",
                  style: System.data.textStyles!.basicLabel,
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
                          widget.onSelectAction!(data);
                        },
                        child: Text(
                          "Ya",
                          style: System.data.textStyles!.boldTitleLightLabel,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
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
                )
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 40,
        width: 100,
        margin: const EdgeInsets.only(left: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: action?.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          action?.label ?? "",
          style: System.data.textStyles!.boldTitleLightLabel,
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
}
