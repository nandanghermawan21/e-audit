import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_kka_model.dart';
import 'package:eaudit/model/audit_kka_reviu_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeleton_text/skeleton_text.dart';
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
            "Kertas Kerja Audit",
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
      child: ListDataComponent<AuditkaReviuModel>(
        controller: listController,
        enableGetMore: false,
        enableDrag: false,
        autoSearch: false,
        dataSource: (skip, key) {
          return AuditkaReviuModel.get(
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
                  "Daftar Kertas Kerja Audit",
                  style: System.data.textStyles!.boldTitleLabel,
                ),
                const SizedBox(
                  height: 10,
                ),
                ...List.generate(data?.listKka?.length ?? 0, (index) {
                  return kkaItem(data, data?.listKka?[index]);
                })
              ],
            ),
          );
        },
      ),
    );
  }

  Widget description(AuditkaReviuModel? data) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: 100,
              child: Text(
                "Kegiatan",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.kegiatan ?? "",
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
                "Tanggal",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                "${data?.startDate == null ? "-" : DateFormat("dd MMMM yyyy", "id_ID").format(data!.startDate!)} s/d ${data?.endDate == null ? "-" : DateFormat("dd MMMM yyyy", "id_ID").format(data!.endDate!)}",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget kkaItem(AuditkaReviuModel? data, AuditKKAModel? kka) {
    return GestureDetector(
      onTap: () {
        widget.onSelectAction!(
          AuditkaReviuModel(
            tipeAudit: data?.tipeAudit,
            kegiatan: data?.kegiatan,
            auditee: data?.auditee,
            startDate: data?.startDate,
            listKka: [kka],
          ),
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
                Text(
                  kka?.noKka ?? "",
                  style: System.data.textStyles!.boldTitleLabel,
                ),
                Text(
                  kka?.tanggal == null
                      ? ""
                      : DateFormat("dd MMMM yyyy").format(kka!.tanggal!),
                  style: System.data.textStyles!.boldTitleLabel,
                ),
              ],
            ),
            Divider(
              height: 10,
              color: Colors.grey.shade400,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Judul", style: System.data.textStyles!.boldTitleLabel),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  kka?.judulKka ?? "",
                  style: System.data.textStyles!.basicLabel,
                ),
              ],
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
                    Text("Status",
                        style: System.data.textStyles!.boldTitleLabel),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      kka?.status ?? "",
                      style: System.data.textStyles!.basicLabel,
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
