import 'package:eaudit/component/circular_loader_component.dart';
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
              loadingController.stopLoading(
                message: "Data Berhasil Tersimpan",
                isError: false,
                duration: const Duration(seconds: 3),
                onCloseCallBack: () {
                  widget.onSubmitSuccess!();
                },
              );
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
        ),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            description(widget.kka),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Reviu Kertas Kerja",
              style: System.data.textStyles!.boldTitleLabel,
            ),
            const SizedBox(
              height: 10,
            ),
            kertasKerja(widget.kka?.listKka?.first),
          ],
        ),
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

  Widget kertasKerja(AuditKKAModel? data) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: 100,
              child: Text(
                "Nomor KKA",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.noKka ?? "",
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
                "Judul KKA",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.judulKka ?? "",
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
                "Dokumen yang diperiksa",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.dokumenYangDiperiksa ?? "",
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
                "Tanggal KKA",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.tanggal == null
                    ? "-"
                    : DateFormat("dd MMMM yyyy").format(data!.tanggal!),
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
                "Uraian",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.uraian ?? "",
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
                "Kesimpulan",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.kesimpulan ?? "",
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
                "File Kertas Kerja",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                data?.fileKertasKerja ?? "",
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
                "Komentar",
                style: System.data.textStyles!.basicLabel,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: List.generate(data?.komentar?.length ?? 0, (index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data?.komentar?[index].name ?? "",
                              style: System.data.textStyles!.boldTitleLabel,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data?.komentar?[index].tanggal == null
                                  ? "-"
                                  : DateFormat("dd MMMM yyyy").format(
                                      (data?.komentar?[index].tanggal!)!,
                                    ),
                              style: System.data.textStyles!.basicLabel,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          data?.komentar?[index].komentar ?? "",
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
      ],
    );
  }
}
