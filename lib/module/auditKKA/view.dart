import 'package:eaudit/component/circular_loader_component.dart';
import 'package:eaudit/component/list_data_component.dart';
import 'package:eaudit/model/audit_kka_model.dart';
import 'package:eaudit/model/audit_kka_reviu_model.dart';
import 'package:eaudit/util/system.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          return Future.value().then(
            (value) {
              return [AuditkaReviuModel.dummy()];
            },
          );
        },
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
                "Obyek Audit",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.objectAudit ?? "",
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
                "Auditor",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data?.auditor ?? "",
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
                "Judul Program",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data?.judulProgram ?? "",
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
                "Prosedur Audit",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.proseduAudit ?? "",
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
            objectAudit: data?.objectAudit,
            judulProgram: data?.judulProgram,
            auditor: data?.auditor,
            proseduAudit: data?.proseduAudit,
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
