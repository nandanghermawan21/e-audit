import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_kkpt_model.dart';
import 'package:eaudit/model/audit_kkpt_reviu_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'presenter.dart';
import 'package:eaudit/component/decoration_component.dart';

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
            "Temuan Audit",
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
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.transparent,
      height: double.infinity,
      width: double.infinity,
      child: ListDataComponent<AuditKKPTReviuModel>(
        controller: listController,
        enableGetMore: false,
        enableDrag: false,
        autoSearch: false,
        dataSource: (skip, key) {
          return AuditKKPTReviuModel.get(
                  token: System.data.global.token, assignId: widget.auditPA?.id)
              .then((value) {
            return [value];
          });
        },
        loaderWidget: SkeletonAnimation(
          shimmerColor: Colors.grey.shade300,
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
        ),
        itemBuilder: (data, index) {
          return Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                description(data),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Daftar Temuan (KKPT)",
                  style: System.data.textStyles!.boldTitleLabel,
                ),
                const SizedBox(
                  height: 10,
                ),
                ...List.generate(data?.listKKPT?.length ?? 0, (index) {
                  return kkptItem(data, data?.listKKPT?[index]);
                })
              ],
            ),
          );
        },
      ),
    );
  }

  Widget description(AuditKKPTReviuModel? data) {
    return Column(
      children: [
        DecorationComponent.item(
          title: "Nama Kegiatan",
          value: data?.namakegiatan ?? "",
        ),
        DecorationComponent.item(
          title: "Auditee",
          value: data?.auditee ?? "",
        ),
        DecorationComponent.item(
          title: "Tipe Audit",
          value: data?.tipeAudit ?? "",
        ),
        DecorationComponent.item(
          title: "Tanggal Audit",
          value: "${data?.tanggalAudit == null ? "-" : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(
              (data!.tanggalAudit!),
            )} s/d ${data?.tanggalAuditEnd == null ? "-" : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(
              (data!.tanggalAuditEnd!),
            )}",
        ),
        // DecorationComponent.item(
        //   title: "No KKA",
        //   value: data?.noKKa ?? "",
        // ),
        // DecorationComponent.item(
        //   title: "Bidang Subtansi",
        //   value: data?.bidangSubtansi ?? "",
        // ),
      ],
    );
  }

  Widget kkptItem(AuditKKPTReviuModel? data, AuditKKPTModel? kkpt) {
    return GestureDetector(
      onTap: () {
        widget.onSelectAction!(
          AuditKKPTReviuModel(
              id: data?.id,
              auditee: data?.auditee,
              bidangSubtansi: data?.bidangSubtansi,
              namakegiatan: data?.namakegiatan,
              noKKa: data?.noKKa,
              tipeAudit: data?.tipeAudit,
              tanggalAudit: data?.tanggalAudit,
              listKKPT: [kkpt]),
          listController,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    kkpt?.judulTemuan ?? "",
                    style: System.data.textStyles!.boldTitleLabel,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status",
                          style: System.data.textStyles!.boldTitleLabel),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        kkpt?.status ?? "",
                        style: System.data.textStyles!.basicLabel,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Rekomendasi",
                        style: System.data.textStyles!.boldTitleLabel),
                    const SizedBox(
                      height: 5,
                    ),
                    CircleAvatar(
                      radius: 15,
                      child: Text(
                        kkpt?.rekomendasi?.toString() ?? "",
                        style: System.data.textStyles!.basicLightLabel,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
